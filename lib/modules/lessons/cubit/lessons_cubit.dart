// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/lessons/models/lessons_response.dart';
import 'package:my_project_new/modules/lessons/models/next_lesson_button_status.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());

  static const List<String> lessonButtonsTitles = [
    "images",
    "attachments",
  ];
  static int _selectedButton = 0;
  static int get selectedButton => _selectedButton;
  static void changeSelectedButton({required int index}) {
    _selectedButton = index;
  }

  List<Lesson> lessons = [];
  Future<void> getLessons({required int unitId}) async {
    emit(GetLessonsLoadingState());
    try {
      final response =
          await Network.getData(url: "${Urls.sections}/$unitId/lessons");

      final LessonsResponse lessonsResponse =
          LessonsResponse.fromJson(response.data);

      lessons = lessonsResponse.data.data;

      emit(GetLessonsSuccessState());
    } on DioException catch (error) {
      emit(GetLessonsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetLessonsErrorState(message: unknownError()));
    }
  }

  late Lesson lessonDetails;

  Future<void> getLessonDetails(
      {required int lessonId, required int unitId}) async {
    emit(GetLessonDetailsLoadingState());
    try {
      final response = await Network.getData(
          url: "${Urls.sections}/$unitId/lessons/$lessonId");

      lessonDetails = Lesson.fromJson(response.data['data']);
      setNextLessonButtonStatus(lessonDetails);
      emit(GetLessonDetailsSuccessState());
    } on DioException catch (error) {
      emit(GetLessonDetailsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetLessonDetailsErrorState(message: unknownError()));
    }
  }

  Future<void> _openNextLesson(int unitId, int lessonId) async {
    emit(OpenNextLessonLoadingState());
    try {
      final Response response = await Network.postData(
          url: '${Urls.sections}/$unitId/lessons/$lessonId/open');
      emit(OpenNextLessonSuccessState(
          nextLessonId: response.data['data']['next_lesson_id']));
    } on DioException catch (error) {
      emit(OpenNextLessonErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(OpenNextLessonErrorState(message: unknownError()));
    }
  }

  void openNextLessons() async {
    if (buttonStatus == NextLessonButtonStatus.OPEN_AND_MOVE ||
        buttonStatus == NextLessonButtonStatus.OPEN_NEXT_UNIT) {
      _openNextLesson(lessonDetails.unitId, lessonDetails.id);
    } else if (buttonStatus ==
        NextLessonButtonStatus.MOVE_ONLY_AND_PREVENT_DOING_TEST) {
      getLessonDetails(
          lessonId: lessonDetails.nextLessonId!, unitId: lessonDetails.unitId);
    }
  }

  NextLessonButtonStatus _buttonStatus = NextLessonButtonStatus.DISABLED;

  NextLessonButtonStatus get buttonStatus => _buttonStatus;

  void setNextLessonButtonStatus(Lesson lesson) {
    if (lesson.nextLessonId == -1) {
      if (lesson.nextUnitId == -1) {
        _buttonStatus = NextLessonButtonStatus.COURSE_END;
      } else if ((lesson.nextUnitId != null) &&
          ((lesson.exam != null && (lesson.exam!.result.pass != null)) ||
              lesson.exam == null)) {
        _buttonStatus = NextLessonButtonStatus.OPEN_NEXT_UNIT;
      } else {
        _buttonStatus = NextLessonButtonStatus
            .DO_TEST_FIRST; // this mean that im in last lesson and i dont pass the test
      }
    } else if (lesson.nextLessonId != null) {
      _buttonStatus = NextLessonButtonStatus.MOVE_ONLY_AND_PREVENT_DOING_TEST;
    } else if (lesson.exam != null && lesson.exam!.result.pass == null) {
      _buttonStatus = NextLessonButtonStatus.DO_TEST_FIRST;
    } else {
      _buttonStatus = NextLessonButtonStatus.OPEN_AND_MOVE;
    }
  }

  Future<void> skipTest({required int lessonId, required int unitId}) async {
    emit(SkipTestLoadingState());
    try {
      final Response response = await Network.postData(
          url: '${Urls.sections}/$unitId/lessons/$lessonId/open?skipped=true');
      emit(SkipTestSuccessState(
        nextLessonId: response.data['data']['next_lesson_id'],
      ));
    } on DioException catch (error) {
      emit(SkipTestErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(SkipTestErrorState(message: unknownError()));
    }
  }
}
