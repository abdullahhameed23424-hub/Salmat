import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/helper/reponse_cacher.dart';
import 'package:salamat/modules/courses/models/coures_response.dart';
import 'package:salamat/modules/courses/models/course.dart';
import 'package:salamat/modules/courses/models/courses_response.dart';
import 'package:salamat/modules/courses/models/my_courses_response.dart';
import 'package:salamat/modules/courses/models/unit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  final RefreshController refreshController = RefreshController();
  int page = 1;
  late CoursesResponse coursesResponse;
  List<Course> courses = [];

  Future<void> getCourses({required int subjectId}) async {
    if (page == 1) {
      print("show loading");
      emit(GetCoursesLoadingState());
    }
    String key = "${Urls.sections}/$subjectId?type=courses&page=1";
    try {
      if (ResponseCacher.hasCache(key)&&page ==1 ) {

        coursesResponse = CoursesResponse.fromJson(ResponseCacher.getCache(key));


          courses = coursesResponse.data.courses;
          emit(GetCoursesSuccessState());

      }


    }catch(error){
      //
    }
    try {
      final Response response = await Network.getData(
        url: "${Urls.sections}/$subjectId?type=courses&page=$page",
      );
      coursesResponse = CoursesResponse.fromJson(response.data);

      if (page > 1) {
        courses.addAll(coursesResponse.data.courses);

        if (coursesResponse.data.courses.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        courses = coursesResponse.data.courses;
      }
      if(page == 1){
        ResponseCacher.cache(key, response.data);
      }
      page = coursesResponse.data.currentPage + 1;

      emit(GetCoursesSuccessState());
    } on DioException catch (error) {

      if(error.type == DioExceptionType.badResponse){
        ResponseCacher.removeCache(key);
        emit(GetCoursesErrorState(message: exceptionsHandle(error: error)));

      }else{
        if(ResponseCacher.hasCache(key) == false){
          emit(GetCoursesErrorState(message: unknownError()));
        }
      }
    } catch (error) {
      print("errro is $error");
      emit(GetCoursesErrorState(message: unknownError()));
    }
  }

  late Course couresDetails;
  List<Unit> units = [];
  Future<void> getCourseDetails({required int courseId}) async {
    emit(GetCourseDetailsLoadingState());

    String key =  "${Urls.sections}/$courseId?type=course_sections";
    try{
      if(ResponseCacher.hasCache(key)) {
        final CourseResponse courseResponse =
        CourseResponse.fromJson(ResponseCacher.getCache(key));
        couresDetails = courseResponse.data.original.coures;
        units = courseResponse.data.original.data.data;

        emit(GetCourseDetailsSuccessState());
      }

    }catch(error){
      //
    }

    try {
      final Response response = await Network.getData(
          url: "${Urls.sections}/$courseId?type=course_sections");

      final CourseResponse courseResponse =
          CourseResponse.fromJson(response.data);
      couresDetails = courseResponse.data.original.coures;
      units = courseResponse.data.original.data.data;
     ResponseCacher.cache(key, response.data);

      emit(GetCourseDetailsSuccessState());
    } on DioException catch (error) {
      if(error.type == DioExceptionType.badResponse) {
        ResponseCacher.removeCache(key);
        emit(GetCourseDetailsErrorState(
            message: exceptionsHandle(error: error)));
      }else{
        if(ResponseCacher.hasCache( key) == false){
          emit(GetCourseDetailsErrorState(
              message: exceptionsHandle(error: error)));
        }

      }
    } catch (error) {
      emit(GetCourseDetailsErrorState(message: unknownError()));
    }
  }

  Future<void> getMycourses() async {
    if (page == 1) {
      emit(GetCoursesLoadingState());
    }
    String key = "${Urls.myCourses}?page=1";
    try{
      if(ResponseCacher.hasCache(key) && page == 1){
        final MyCoursesResponse coursesResponse =
        MyCoursesResponse.fromJson(ResponseCacher.getCache(key));
        courses = coursesResponse.data.courses;
        emit(GetCoursesSuccessState());


      }
    }catch(error){

    }
    try {
      final Response response =
          await Network.getData(url: "${Urls.myCourses}?page=$page");
      final MyCoursesResponse coursesResponse =
          MyCoursesResponse.fromJson(response.data);

      if (page > 1) {
        courses.addAll(coursesResponse.data.courses);

        if (coursesResponse.data.courses.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        courses = coursesResponse.data.courses;
      }
      if(page == 1){
        ResponseCacher.cache(key, response.data);
      }
      page = coursesResponse.data.currentPage + 1;

      emit(GetCoursesSuccessState());
    } on DioException catch (error) {

      if(error.type == DioExceptionType.badResponse){
        ResponseCacher.removeCache(key);
        emit(GetCoursesErrorState(message: exceptionsHandle(error: error)));
      }else{
        if(ResponseCacher.hasCache(key) == false){
          emit(GetCoursesErrorState(message: unknownError()));
        }
      }

    } catch (error) {
      emit(GetCoursesErrorState(message: unknownError()));
    }
  }

  Future<void> subscribeToCourse({required int courseId}) async {
    try {
      emit(SubscribeToCourseLoadingState());
      await Network.postData(url: "${Urls.sections}/$courseId/open");
      emit(SubscribeToCourseSuccessState());
    } on DioException catch (error) {
      emit(
          SubscribeToCourseErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(SubscribeToCourseErrorState(message: unknownError()));
    }
  }
}
