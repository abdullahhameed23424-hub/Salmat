import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/library/models/library_book.dart';
import 'package:my_project_new/modules/library/models/library_books_response.dart';
import 'package:my_project_new/modules/library/models/library_response.dart';
import 'package:my_project_new/modules/library/models/library_section.dart';
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
    if (page == 1) {
      emit(LibraryLoadingState());
    }

    try {
      final response = await Network.getData(
          url: "${Urls.sections}?type=book_section&page=$page");
      final LibrarySectionsResponse librarySectionsResponse =
          LibrarySectionsResponse.fromJson(response.data);

      if (page == 1) {
        librarySections = librarySectionsResponse.data.original.data.data;
        refreshController.loadComplete();

        image = librarySectionsResponse.extraData.image;
        description = librarySectionsResponse.extraData.description;
      } else {
        librarySections.addAll(librarySectionsResponse.data.original.data.data);

        if (librarySectionsResponse.data.original.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }

      page = librarySectionsResponse.data.original.data.currentPage + 1;
      emit(LibrarySuccessState());
    } on DioException catch (error) {
      emit(LibraryErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LibraryErrorState(message: unknownError()));
    }
  }

  List<Book> libraryBooks = [];
  Future<void> getBooks(int librarySectionId) async {
    if (page == 1) {
      emit(LibraryLoadingState());
    }
    try {
      final response = await Network.getData(
          url: "${Urls.sections}/$librarySectionId/books?page=$page");
      final LibraryBooksResponse libraryBooksResponse =
          LibraryBooksResponse.fromJson(response.data);

      if (page == 1) {
        libraryBooks = libraryBooksResponse.data.data;
        refreshController.loadComplete();
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
      emit(LibraryErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LibraryErrorState(message: unknownError()));
    }
  }
}
