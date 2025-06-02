import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';
import 'package:my_project_new/modules/test/view/widgets/question_card.dart';
import 'package:my_project_new/modules/test/view/widgets/question_icon.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({
    super.key,
    required this.examCubit,
  });

  final TestCubit examCubit;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: examCubit.questions.length,
      itemBuilder: (context, index) {
        final question = examCubit.questions[index];
        return QuestionForm(question: question, examCubit: examCubit);
      },
    );
  }
}

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    super.key,
    required this.question,
    required this.examCubit,
  });

  final Question question;
  final TestCubit examCubit;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          QuestionCard(
            question: widget.question,
            examCubit: widget.examCubit,
            test: widget.examCubit.test,
          ),
          QuestionIcon(
              examCubit: widget.examCubit), // to go to explanation screen
        ],
      ),
    );
  }
}
