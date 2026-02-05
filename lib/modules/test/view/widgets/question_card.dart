import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/modules/test/models/test_response.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  // Wrap the content in proper HTML structure with RTL support

  late WebViewController webViewController;

  @override
  final String fullHtml = """
    <!DOCTYPE html>
    <html lang="ar">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        body {
          direction: rtl;       /* force RTL */
          text-align: right;    /* align text to right */
          font-family: 'Arial', sans-serif;
        }
        img {
          max-width: 100%;      /* responsive images */
          height: auto;
        }
      </style>
    </head>
    <body>
      // 
    </body>
    </html>
    """;

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
//           SizedBox(
//             height: 150.h,
//             child: SingleChildScrollView(
//               child: TeXView(
//                 style: TeXViewStyle.fromCSS(
//                     '''
//                      height: 100%;
//       word-wrap: break-word;
//       overflow-wrap: break-word;
//       white-space: normal;
//       padding: 15px;
//
// '''),
//                 child:
//                   TeXViewDocument(widget.question.text,
//                       style: const TeXViewStyle(textAlign: TeXViewTextAlign.right),
//
//
//                   ),
//
//
//
//                     // ,            wantKeepAlive: true,
//
//
//               ),
//             ),
//           ),

          SizedBox(
            height: 180.h,
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.disabled)
                ..loadHtmlString(
                  """
          <!DOCTYPE html>
          <html lang="ar">
   
         
          <body style="overflow-x: auto; direction: rtl; text-align: right;">
            ${widget.question.text}
          </body>
          </html>
          """,
                ),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer()),
              },
            ),
          ),
          Divider(),
          // HtmlWidget(
          //   widget.question.text,
          //   customStylesBuilder: (element) {
          //       return {
          //         'direction': 'rtl',
          //         'text-align': 'right',
          //         'unicode-bidi': 'embed',
          //      };
          //   }
          // ),

          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: HtmlWidget(
          //     '<div dir="auto" >${widget.question.text}</div>',
          //   ),
          // ),
          // HtmlWidget(
          //   widget.question.text,
          // ),
          ...List.generate(
            widget.question.options.length,
            (optionIndex) {
              final bool isChosen =
                  widget.question.options[optionIndex].isChosen;
              final bool isTrue = widget.question.options[optionIndex].isTrue;
              Color? tileColor;
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
                  title: Directionality(
                    textDirection: TextDirection.ltr,
                    child: HtmlWidget(
                      widget.question.options[optionIndex].name,
                      textStyle: titilliumRegular,
                    ),
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
