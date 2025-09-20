import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/modules/test/models/test_response.dart';

class ReadOnlyQuestionCard extends StatefulWidget {
  const ReadOnlyQuestionCard(
      {super.key,
      required this.question,
      this.padding,
      this.color,
      required this.test});
  final Question question;
  final EdgeInsets? padding;
  final Color? color;
  final Test test;

  @override
  State<ReadOnlyQuestionCard> createState() => _ReadOnlyQuestionCardState();
}

class _ReadOnlyQuestionCardState extends State<ReadOnlyQuestionCard> {
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

              if (isTrue) {
                tileColor = AppColors.LIGHT_GREEN.withAlpha(200);
              } else if (isChosen) {
                tileColor = AppColors.PURPLE_LIGHT.withAlpha(200);
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
                  onChanged: null,
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
