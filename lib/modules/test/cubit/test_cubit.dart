import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/modules/test/models/completed_tests_response.dart';
import 'package:salamat/modules/test/models/result.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/modules/test/models/test_response.dart';

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

      if (!AppSharedPreferences.isGuest &&
          test.result.pass == null &&
          // test.isSubscribed &&
          !test.isSolving &&
          !(test.studentExam?.skipped ?? false)) {
        createExam(test.id);
      }

      if ((test.result.pass == false && (test.studentExam?.skipped ?? false)) ||
          (test.result.pass == true)) {
        print("case:1");
        testTime = test.minutes * 60;
      } else if (test.isSolving) {
        print("case:2");
        isSolving = true;
        testTime = test.remainingTime.toInt();
        if (testTime.isNegative) {
          submitExam(examId: test.id, force: true);
        }
      } else {
        print("case:3");
        testTime = test.minutes * 60;
        isSolving = true;
      }
      if (isClosed) return;
      emit(GetTestSuccessState());
    } on DioException catch (error) {
      if (isClosed) return;
      emit(GetTestErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      if (isClosed) return;
      emit(GetTestErrorState(message: unknownError()));
    }
  }

  Future<void> createExam(int examId) async {
    emit(StartExamLoadingState());
    try {
      await Network.postData(url: '${Urls.studentExams}/$examId/create');

      isSolving = true;
      if (isClosed) return;
      emit(StartExamSuccessState());
    } on DioException catch (e) {
      if (isClosed) return;
      emit(StartExamErrorState(message: exceptionsHandle(error: e)));
    } catch (e) {
      if (isClosed) return;
      emit(StartExamErrorState(message: unknownError()));
    }
  }

  List<Map<String, int>> selectedOptions = [];

  void onOptionTapped(Question question, int optionIndex, bool value) {
    if (state is SubmitExamLoadingState) {
      return;
    }
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

  Future<void> submitExam({required int examId, bool force = false}) async {
    if (selectedOptions.any((option) => option['option_id'] == -1) && !force) {
      if (isClosed) return;
      emit(SubmitExamErrorState(message: "يرجى حل جميع الأسئلة"));
      return;
    }
    if (isClosed) return;
    emit(SubmitExamLoadingState());
    try {
      final response = await Network.postData(
        url: '${Urls.studentExams}/$examId/store',
        data: {
          'answers': selectedOptions,
        },
      );
      isSolving = false;

      if (response.data['data']['pass'] ?? true) {
        // this mean that the student is success and in this case back return the exam

        final Test testResponse = Test.fromJson(response.data['data']);
        test = testResponse;
        questions = test.questions;
        emit(SubmitExamSuccessState(result: testResponse.result));
      } else {
        final Result failedResult = Result.fromJson(response.data['data']);
        test.result.studentDegree = failedResult.studentDegree;
        test.studentExam?.attemptCount =
            (test.studentExam?.attemptCount ?? 0) + 1;
        test.studentExam?.skipped = false;
        test.result.examDegree = failedResult.examDegree;
        if (isClosed) return;
        emit(SubmitExamSuccessState(result: failedResult));
        // this mean that the student is failed and in this case back return the result only
      }
    } on DioException catch (e) {
      if (isClosed) return;
      emit(SubmitExamErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      if (isClosed) return;
      emit(SubmitExamErrorState(message: unknownError()));
    }
  }

  int nextLessonId = 0;
  List<Test> tests = [];
  String image = '';

  Future<void> getCompletedTests() async {
    emit(GetCompletedTestsLoadingState());
    try {
      final Response response =
          await Network.getData(url: "${Urls.completedTests}?paginate=1");
      final CompletedTestsResponse completedTestsResponse =
          CompletedTestsResponse.fromJson(response.data);
      tests = completedTestsResponse.data.original.data.data;
      image = completedTestsResponse.extraData.authExams.image ?? '';
      if (isClosed) return;
      emit(GetCompletedTestsSuccessState());
    } on DioException catch (e) {
      if (isClosed) return;
      emit(GetCompletedTestsErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      if (isClosed) return;
      print("show the error $error");
      emit(GetCompletedTestsErrorState(message: unknownError()));
    }
  }
}
