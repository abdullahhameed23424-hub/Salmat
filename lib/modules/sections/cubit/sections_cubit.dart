import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/modules/sections/models/section.dart';
import 'package:salamat/modules/sections/models/sections_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../helper/reponse_cacher.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late SectionsResponse sectionsResponse;
  List<Section> sections = [];

  Future<void> getSections() async {
    if (page == 1) {
      emit(GetSectionsLoadingState());
    }
    String key = "${Urls.sections}?type=super&page=1";

    try {
      if (ResponseCacher.hasCache(key) && page == 1) {
        sectionsResponse =
            SectionsResponse.fromJson(ResponseCacher.getCache(key));

        sections = sectionsResponse.data.sections;
        if (isClosed) return;
        emit(GetSectionsSuccessState());
      }
    } catch (error) {
      //
    }

    try {
      Response response = await Network.getData(
        url: "${Urls.sections}?type=super&page=$page",
      );

      sectionsResponse = SectionsResponse.fromJson(response.data);

      if (page > 1) {
        sections.addAll(sectionsResponse.data.sections);

        if (sectionsResponse.data.sections.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        sections = sectionsResponse.data.sections;
      }
      if (page == 1) {
        ResponseCacher.cache(key, response.data);
      }
      page = sectionsResponse.data.currentPage + 1;
      if (isClosed) return;
      emit(GetSectionsSuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        ResponseCacher.removeCache(key);
        if (isClosed) return;
        emit(GetSectionsErrorState(message: exceptionsHandle(error: error)));
      } else {
        if (ResponseCacher.hasCache(key) == false) {
          if (isClosed) return;
          emit(GetSectionsErrorState(message: unknownError()));
        }
      }
    } catch (error) {
      emit(GetSectionsErrorState(message: unknownError()));
    }
  }
}
