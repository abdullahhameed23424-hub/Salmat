import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/helper/reponse_cacher.dart';
import 'package:salamat/modules/library/models/library_book.dart';
import 'package:salamat/modules/library/models/library_books_response.dart';
import 'package:salamat/modules/library/models/library_response.dart';
import 'package:salamat/modules/library/models/library_section.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryInitial());

  List<LibrarySection> librarySections = [];
  RefreshController refreshController = RefreshController();
  int page = 1;

  String image = '';
  String description = '';
  Future<void> getLibrarySections() async {
    final bool isFirstPageRequest = page == 1;
    if (isFirstPageRequest) {
      emit(LibraryLoadingState());
    }

    const String cacheKey = "${Urls.sections}?type=book_section&page=1";

    if (isFirstPageRequest) {
      try {
        if (ResponseCacher.hasCache(cacheKey)) {
          final cachedResponse = LibrarySectionsResponse.fromJson(
              ResponseCacher.getCache(cacheKey));
          librarySections = cachedResponse.data.original.data.data;
          image = cachedResponse.extraData.image;
          description = cachedResponse.extraData.description;
          refreshController.loadComplete();
          if (isClosed) return;
          emit(LibrarySuccessState());
        }
      } catch (_) {
        // ignore cache parsing errors and proceed to network call
      }
    }

    try {
      final response = await Network.getData(
        url: "${Urls.sections}?type=book_section&page=$page",
      );
      final LibrarySectionsResponse librarySectionsResponse =
          LibrarySectionsResponse.fromJson(response.data);

      if (page == 1) {
        librarySections = librarySectionsResponse.data.original.data.data;
        refreshController.loadComplete();
        image = librarySectionsResponse.extraData.image;
        description = librarySectionsResponse.extraData.description;
        await ResponseCacher.cache(cacheKey, response.data);
      } else {
        librarySections.addAll(librarySectionsResponse.data.original.data.data);

        if (librarySectionsResponse.data.original.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }

      page = librarySectionsResponse.data.original.data.currentPage + 1;
      if (isClosed) return;
      emit(LibrarySuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        await ResponseCacher.removeCache(cacheKey);
        if (isClosed) return;
        emit(LibraryErrorState(message: exceptionsHandle(error: error)));
      } else {
        if (isFirstPageRequest && !ResponseCacher.hasCache(cacheKey)) {
          if (isClosed) return;
          emit(LibraryErrorState(message: unknownError()));
        }
      }
    } catch (error) {
      if (isFirstPageRequest && !ResponseCacher.hasCache(cacheKey)) {
        if (isClosed) return;
        emit(LibraryErrorState(message: unknownError()));
      }
    }
  }

  List<Book> libraryBooks = [];
  Future<void> getBooks(int librarySectionId) async {
    final bool isFirstPageRequest = page == 1;
    if (isFirstPageRequest) {
      emit(LibraryLoadingState());
    }

    final String cacheKey = "${Urls.sections}/$librarySectionId/books?page=1";

    if (isFirstPageRequest) {
      try {
        if (ResponseCacher.hasCache(cacheKey)) {
          final cachedBooks =
              LibraryBooksResponse.fromJson(ResponseCacher.getCache(cacheKey));
          libraryBooks = cachedBooks.data.data;
          refreshController.loadComplete();
          if (isClosed) return;
          emit(LibrarySuccessState());
        }
      } catch (_) {
        // ignore cache parsing errors
      }
    }

    try {
      final response = await Network.getData(
        url: "${Urls.sections}/$librarySectionId/books?page=$page",
      );
      final LibraryBooksResponse libraryBooksResponse =
          LibraryBooksResponse.fromJson(response.data);

      if (page == 1) {
        libraryBooks = libraryBooksResponse.data.data;
        refreshController.loadComplete();
        await ResponseCacher.cache(cacheKey, response.data);
      } else {
        libraryBooks.addAll(libraryBooksResponse.data.data);
        if (libraryBooksResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }

      page = libraryBooksResponse.data.currentPage + 1;
      emit(LibrarySuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        await ResponseCacher.removeCache(cacheKey);
        if (isClosed) return;
        emit(LibraryErrorState(message: exceptionsHandle(error: error)));
      } else {
        if (isFirstPageRequest && !ResponseCacher.hasCache(cacheKey)) {
          if (isClosed) return;
          emit(LibraryErrorState(message: unknownError()));
        }
      }
    } catch (error) {
      if (isFirstPageRequest && !ResponseCacher.hasCache(cacheKey)) {
        if (isClosed) return;
        emit(LibraryErrorState(message: unknownError()));
      }
    }
  }
}
