import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
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
        return QuestionForm(
            question: question, examCubit: examCubit, index: index);
      },
    );
  }
}

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    super.key,
    required this.question,
    required this.examCubit,
    required this.index,
  });

  final Question question;
  final TestCubit examCubit;
  final int index;

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
              question: widget.question,
              examCubit: widget.examCubit), // to go to explanation screen
          QutionNumber(widget: widget),
        ],
      ),
    );
  }
}

class QutionNumber extends StatelessWidget {
  const QutionNumber({
    super.key,
    required this.widget,
  });

  final QuestionForm widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.LOGO_PRIMARY),
        child: Text(
          (widget.index + 1).toString(),
          style: titilliumBold.copyWith(color: Colors.white, fontSize: 20.sp),
        ),
      ),
    );
  }
}
