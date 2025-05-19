import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      required this.question,
      required this.examCubit,
      this.padding,
      this.color});
  final Question question;
  final TestCubit examCubit;
  final EdgeInsets? padding;
  final Color? color;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.fromLTRB(16.w, 34.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.WHITE,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.question.text,
            style: titilliumRegular,
          ),
          ...List.generate(
            widget.question.options.length,
            (optionIndex) {
              Color? tileColor;

              if (widget.examCubit.isSubmitted) {
                if (widget.question.options[optionIndex].isTrue) {
                  tileColor = AppColors.LIGHT_GREEN.withAlpha(200);
                } else if (widget.question.options[optionIndex].isChosen) {
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
                  checkColor: AppColors.PRIMARY,
                  fillColor: WidgetStatePropertyAll(AppColors.LIGHTGRAY),
                  value: widget.question.options[optionIndex].isChosen,
                  onChanged: (value) {
                    if (widget.examCubit.isSubmitted) {
                      return;
                    }
                    setState(() {
                      if (value!) {
                        widget.question.options[optionIndex].isChosen = true;
                      } else {
                        widget.question.options[optionIndex].isChosen = false;
                      }
                    });
                  },
                  title: Text(
                    widget.question.options[optionIndex].name,
                    style: titilliumRegular,
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
