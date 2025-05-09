import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/courses/models/course.dart';
import 'package:my_project_new/modules/courses/models/courses_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late CoursesResponse coursesResponse;
  List<Course> subjects = [];

  Future<void> getCourses({required int subjectId}) async {
    if (page == 1) {
      emit(GetCoursesLoadingState());
    }
    try {
      Response response = await Network.getData(
        url: "${Urls.sections}/$subjectId/subjects/?page=$page",
      );
      coursesResponse = CoursesResponse.fromJson(response.data);

      if (page > 1) {
        subjects.addAll(coursesResponse.data.courses);

        if (coursesResponse.data.courses.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        subjects = coursesResponse.data.courses;
      }
      page = coursesResponse.data.currentPage + 1;

      emit(GetCoursesSuccessState());
    } on DioException catch (error) {
      emit(GetCoursesErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetCoursesErrorState(message: unknownError()));
    }
  }
}
