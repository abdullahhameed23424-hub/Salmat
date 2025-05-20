import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/test/models/result.dart';
import 'package:my_project_new/modules/test/models/test.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  bool isSolving = false;

  List<Question> questions = [];

  late Test test;
  int testTime = 0;

  Future<void> getTest(int examId) async {
    emit(GetTestLoadingState());
    try {
      final response = await Network.getData(url: "${Urls.exams}/$examId");

      final TestResponse testResponse = TestResponse.fromJson(response.data);
      questions = testResponse.data.questions;
      test = testResponse.data;
      selectedOptions = List.generate(questions.length,
          (index) => {'question_id': questions[index].id, 'option_id': -1});

      if (test.result.pass == null && test.isSubscribed && !test.isSolving) {
        createExam(test.id);
      } else {
        if (test.result.pass != null) {
          // student is success
          testTime = test.minutes * 60;
        } else if (test.isSolving) {
          // student is solving
          isSolving = true;

          testTime = test.remainingTime.toInt();
        } else {
          // student is not solving yet
          testTime = test.minutes * 60;
          isSolving = true;
        }

        emit(GetTestSuccessState());
      }
    } on DioException catch (error) {
      emit(GetTestErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetTestErrorState(message: unknownError()));
    }
  }

  Future<void> createExam(int examId) async {
    emit(StartExamLoadingState());
    try {
      await Network.postData(
        url: '${Urls.studentExams}/$examId/create',
      );

      isSolving = true;
      emit(StartExamSuccessState());
    } on DioException catch (e) {
      emit(StartExamErrorState(message: exceptionsHandle(error: e)));
    } catch (e) {
      emit(StartExamErrorState(message: unknownError()));
    }
  }

  List<Map<String, int>> selectedOptions = [];

  void onOptionTaped(Question question, int optionIndex, bool value) {
    if (value) {
      for (var option in question.options) {
        if (option.isChosen) {
          option.isChosen = false;
        }
      }
      question.options[optionIndex].isChosen = true;
      choseOption(question.id, question.options[optionIndex].id);
    } else {
      question.options[optionIndex].isChosen = false;
      unchoseOption(question.id);
    }
  }

  void choseOption(int questionId, int optionId) {
    selectedOptions
        .where((element) => element['question_id'] == questionId)
        .forEach((element) {
      element['option_id'] = optionId;
    });
  }

  void unchoseOption(int questionId) {
    selectedOptions
        .where((element) => element['question_id'] == questionId)
        .forEach((element) {
      element['option_id'] = -1;
    });
  }

  Future<void> submitExam(int examId) async {
    print("selectedOptions: $selectedOptions");
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
      isSolving = false;
      final TestResponse testResponse =
          TestResponse.fromJson(response.data['data']);
      test = testResponse.data;
      emit(SubmitExamSuccessState(result: testResponse.data.result));
    } on DioException catch (e) {
      emit(SubmitExamErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      emit(SubmitExamErrorState(message: unknownError()));
    }
  }

  int nextLessonId = 0;

  
}
