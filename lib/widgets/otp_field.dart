import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';

import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.authCubit,
    required this.email,
    required this.task,
    required this.state,
    this.onCompleted,
  });

  final AuthCubit authCubit;
  final String email;
  final String task;
  final AuthState state;
  final void Function(String)? onCompleted;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        focusNode: authCubit.otpFocusNode,
        length: 6,
        readOnly: state is CheckCodeLoadingState,
        keyboardType: TextInputType.number,
        controller: authCubit.otpController,
        defaultPinTheme: PinTheme(
            width: 45.w,
            height: 45.w,
            textStyle: titilliumBold,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.DARK_GRAY.withOpacity(0.2),
            )),
        onCompleted: onCompleted ??
            (value) {
              authCubit.checkCode(email: email, task: task);
            },
      ),
    );
  }
}
