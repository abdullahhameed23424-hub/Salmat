import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/widgets/custom_button.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.testCubit,
    required this.onTryAgain,
    required this.state,
  });

  final TestCubit testCubit;

  final SubmitExamSuccessState state;
  final void Function() onTryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${state.result.studentDegree} / ${state.result.examDegree}",
          style: titilliumBold,
        ),
        Text(
          translate('failed', context),
          style: titilliumBold,
        ),
        SizedBox(height: 20.h),
        CustomButton(
          onPressed: onTryAgain,
          label: translate('try_again', context),
        ),
      ],
    );
  }
}
