import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/models/test_response.dart';
import 'package:salamat/modules/test/view/widgets/question_card.dart';
import 'package:salamat/modules/test/view/widgets/question_icon.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({
    super.key,
    required this.examCubit,
  });

  final TestCubit examCubit;

  @override
  Widget build(BuildContext context) {

    return SliverList.list(

      //
      // itemCount: examCubit.questions.length,
      //
      // itemBuilder: (context, index) {
      //   final question = examCubit.questions[index];
      //   return QuestionForm(
      //       question: question, examCubit: examCubit, index: index);
      // },
      children: [
        for(int index=0;index<examCubit.questions.length;index++)
          QuestionForm(
              question: examCubit.questions[index], examCubit: examCubit, index: index),
      ],



    );
    // return SliverToBoxAdapter(
    //   child: TeXView(
    //     child: TeXViewColumn(
    //       Tex
    //       children: [
    //         for (int index = 0; index < examCubit.questions.length; index++)
    //           TeXViewContainer(
    //             style: const TeXViewStyle(
    //                 backgroundColor: AppColors.WHITE,
    //               margin: TeXViewMargin.all(32),
    //             ),
    //
    //
    //               child:  TeXViewColumn(
    //               children: [
    //                   TeXViewDocument(examCubit.questions[index].text,
    //                       style: const TeXViewStyle(
    //                           textAlign: TeXViewTextAlign.right)),
    //
    //
    //                   TeXViewColumn(
    //                     style: TeXViewStyle(
    //
    //                     ),
    //                     children: [
    //                       for(int i=0;i<examCubit.questions[index].options.length;i++)
    //                         TeXViewDocument(
    //                           examCubit.questions[index].options[i].name,
    //                           style: const TeXViewStyle(
    //                               textAlign: TeXViewTextAlign.right),
    //
    //                         )
    //
    //
    //                     ],
    //                   )
    //                 ],
    //               )
    //           )
    //
    //       ],
    //
    //       // itemCount: examCubit.questions.length,
    //       //
    //       // itemBuilder: (context, index) {
    //       //   final question = examCubit.questions[index];
    //       //   return QuestionForm(
    //       //       question: question, examCubit: examCubit, index: index);
    //       // },
    //     ),
    //   ),
    // );
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
          QuestionNumber(widget: widget),
          QuestionNumber(widget: widget),
          QuestionDegree(widget: widget)
        ],
      ),
    );
  }
}

class QuestionNumber extends StatelessWidget {
  const QuestionNumber({
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

class QuestionDegree extends StatelessWidget {
  const QuestionDegree({
    super.key,
    required this.widget,
  });

  final QuestionForm widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: AppColors.PRIMARY, borderRadius: BorderRadius.circular(5)),
        child: Text(
          translate("marks", context,
              args: [widget.question.degree.toString()]),
          style:
              titilliumBold.copyWith(color: AppColors.WHITE, fontSize: 14.sp),
        ),
      ),
    );
  }
}
