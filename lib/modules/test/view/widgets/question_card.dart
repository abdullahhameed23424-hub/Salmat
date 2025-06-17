import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/models/test.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.examCubit,
      this.padding,
      this.color,
      required this.test});
  final Question question;
  final TestCubit examCubit;
  final EdgeInsets? padding;
  final Color? color;
  final Test test;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.fromLTRB(16.w, 45.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.WHITE,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HtmlWidget(
            widget.question.text,
            textStyle: titilliumRegular,
          ),
          ...List.generate(
            widget.question.options.length,
            (optionIndex) {
              final bool isChosen =
                  widget.question.options[optionIndex].isChosen;
              final bool isTrue = widget.question.options[optionIndex].isTrue;
              Color? tileColor;
              print(
                  "==2====Option: ${widget.question.options[optionIndex].name}, is_true: ${widget.question.options[optionIndex].isTrue} (is_chosen: ${widget.question.options[optionIndex].isChosen})");
              final bool isSuccessIn = (widget.test.result.pass == true ||
                  (widget.test.result.pass == false &&
                      (widget.test.studentExam?.skipped ?? false)));

              if (!widget.examCubit.isSolving && isSuccessIn) {
                if (isTrue) {
                  tileColor = AppColors.LIGHT_GREEN.withAlpha(200);
                } else if (isChosen) {
                  tileColor = AppColors.PURPLE_LIGHT.withAlpha(200);
                }
              }

              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: tileColor,
                ),
                child: CheckboxListTile(
                  checkColor: AppColors.LIGHTGRAY,
                  fillColor: WidgetStatePropertyAll(
                      isChosen ? AppColors.PRIMARY : AppColors.LIGHTGRAY),
                  value: widget.question.options[optionIndex].isChosen,
                  onChanged: (value) {
                    if (!widget.examCubit.isSolving) {
                      return;
                    }
                    widget.examCubit
                        .onOptionTapped(widget.question, optionIndex, value!);
                    setState(() {});
                  },
                  title: HtmlWidget(
                    widget.question.options[optionIndex].name,
                    textStyle: titilliumRegular,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
