import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/modules/test/models/question.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  bool isSubmitted = false;
  void submitExam() {
    isSubmitted = true;
    emit(ExamSuccessState());
  }

  List<Question> questions = List.generate(
    3,
    (index) => Question(
      correctAnswerIndex: 1,
      text: 'المقدار 2x(x+3)-(x+3) يساوي:' * 3,
      options: ['2(x+1)(x+3)' * 3, '2x+3' * 2, 'x(2x+3)' * 5],
    ),
  )

      // ...
      ;
}
