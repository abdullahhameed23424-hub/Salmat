import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/subjects/models/subject.dart';
import 'package:my_project_new/modules/subjects/models/subjects_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late SubjectsResponse subjectsResponse;
  List<Subject> subjects = [];
  String headerText = '';
  String headerImage = '';
  Future<void> getSubjects({required int sectionId}) async {
    if (page == 1) {
      emit(GetSubjectsLoadingState());
    }
    try {
      Response response = await Network.getData(
        url: "${Urls.sections}/$sectionId?type=subjects&page=$page",
      );
      subjectsResponse = SubjectsResponse.fromJson(response.data);

      if (page > 1) {
        subjects.addAll(subjectsResponse.data.seubjects);

        if (subjectsResponse.data.seubjects.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        subjects = subjectsResponse.data.seubjects;
        headerImage = subjectsResponse.exteraData.image;
        headerText = subjectsResponse.exteraData.headerText;
      }
      page = subjectsResponse.data.currentPage + 1;

      emit(GetSubjectsSuccessState());
    } on DioException catch (error) {
      emit(GetSubjectsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetSubjectsErrorState(message: unknownError()));
    }
  }
}
