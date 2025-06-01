import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/view/screens/question_explanation_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class QuestionIcon extends StatelessWidget {
  const QuestionIcon({
    super.key,
    required this.examCubit,
  });
  final TestCubit examCubit;
  @override
  Widget build(BuildContext context) {
    if (!examCubit.isSolving && (examCubit.test.result.pass??true)) {
      return _QuestionMarkButton(examCubit: examCubit);
    }

    return _OnlyIcon();
  }
}

class _OnlyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: -25.h,
      end: 20.w,
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.SECONDRY, width: 2),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            Images.questionIcon,
            width: 45.w,
          )),
    );
  }
}

class _QuestionMarkButton extends StatelessWidget {
  final TestCubit examCubit;

  const _QuestionMarkButton({required this.examCubit});
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: -35.h,
      end: 20.w,
      child: InkWell(
        onTap: () {
          pushTo(
              context: context,
              toPage: QuestionExplanationScreen(
                examCubit: examCubit,
              ));
        },
        child: ElasticIn(
          child: Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.SECONDRY, width: 2),
                  color: Colors.white,
                  shape: BoxShape.circle),
              child: Image.asset(Images.questionMark, width: 35.w)),
        ),
      ),
    );
  }
}
