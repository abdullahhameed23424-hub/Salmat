import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/lessons/models/lessons_response.dart';

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
  Future<void> getLessonDetails({required Lesson lesson}) async {
    emit(GetLessonDetailsLoadingState());
    try {
      final response = await Network.getData(
          url: "${Urls.sections}/${lesson.unitId}/lessons/${lesson.id}");

      lessonDetails = Lesson.fromJson(response.data['data']);
      emit(GetLessonDetailsSuccessState());
    } on DioException catch (error) {
      emit(GetLessonDetailsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetLessonDetailsErrorState(message: unknownError()));
    }
  } 
  Future<void> openNextLesson(int coursseId, int lessonId) async {
    emit(OpenNextLessonLoadingState());
    try {
      final Response response = await Network.postData(
          url: '${Urls.sections}/$coursseId/lessons/$lessonId/open');
      emit(OpenNextLessonSuccessState(
          nextLessonId: response.data['data']['next_lesson_id']));
    } on DioException catch (error) {
      emit(OpenNextLessonErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(OpenNextLessonErrorState(message: unknownError()));
    }
  }
}
