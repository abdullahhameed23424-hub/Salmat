import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/sections/models/section.dart';
import 'package:my_project_new/modules/sections/models/sections_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late SectionsResponse sectionsResponse;
  List<Section> sections = [];
  String headerText = '';
  Future<void> getSections() async {
    if (page == 1) {
      emit(GetSectionsLoadingState());
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
        headerText = sectionsResponse.extraData.headerText;
      }
      page = sectionsResponse.data.currentPage + 1;

      emit(GetSectionsSuccessState());
    } on DioException catch (error) {
      emit(GetSectionsErrorState(message: exceptionsHandle(error: error)));
    }
    // catch (error) {
    //   emit(GetSectionsErrorState(message: unknownError()));
    // }
  }
}
