import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/test/models/test.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  bool isSubmitted = false;

  List<Question> questions = [];

  late Test test;
  Future<void> getTest(int examId) async {
    emit(GetTestLoadingState());
    try {
      final response = await Network.getData(url: "${Urls.exams}/$examId");

      final TestResponse testResponse = TestResponse.fromJson(response.data);
      questions = testResponse.data.questions;
      test = testResponse.data;
      selectedOptions = List.generate(questions.length,
          (index) => {'question_id': questions[index].id, 'option_id': -1});
          
      emit(GetTestSuccessState());
    } on DioException catch (error) {
      emit(GetTestErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetTestErrorState(message: unknownError()));
    }
  }

  Future<void> startExam(int examId) async {
    emit(StartExamLoadingState());
    try {
      await Network.postData(
        url: '${Urls.studentExams}/$examId/start',
      );
      emit(StartExamSuccessState());
    } on DioException catch (e) {
      emit(StartExamErrorState(message: exceptionsHandle(error: e)));
    } catch (e) {
      emit(StartExamErrorState(message: unknownError()));
    }
  }

  List<Map<String, int>> selectedOptions = [];

  Future<void> submitExam(int examId) async {
    emit(SubmitExamLoadingState());
    if (selectedOptions.any((option) => option['option_id'] == -1)) {
      emit(SubmitExamErrorState(message: "يرجى حل جميع الأسئلة"));
      return;
    }

    try {
      final response = await Network.postData(
        url: '${Urls.studentExams}/$examId/store',
        data: {
          'answers': selectedOptions,
        },
      );

      test = Test.fromJson(response.data['data']);

      emit(SubmitExamSuccessState());
    } on DioException catch (e) {
      emit(SubmitExamErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      emit(SubmitExamErrorState(message: "حدث خطأ ما"));
    }
  }
}
