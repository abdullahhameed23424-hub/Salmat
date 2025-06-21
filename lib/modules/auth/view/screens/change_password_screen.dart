import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart'; // Add this import
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/core/validators/confirm_password_validator.dart';
import 'package:salamat/core/validators/password_validator.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate("change_password", context),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangePasswordSuccessState) {
                customSnackBar(
                  context,
                  success: 1,
                  message: "تم تغيير كلمة المرور بنجاح",
                );
                Navigator.pop(context);
              } else if (state is ChangePasswordErrorState) {
                customSnackBar(
                  context,
                  success: 0,
                  message: state.message,
                );
              }
            },
            builder: (context, state) {
              final AuthCubit authCubit = context.read<AuthCubit>();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Form(
                  key: authCubit.formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 35.h),
                      FadeInDown(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 500),
                        child: CustomTextField(
                          isPassword: true,
                          radius: 50.r,
                          keyboardtype: TextInputType.visiblePassword,
                          label: translate("old_password", context),
                          controller: authCubit.oldPasswordController,
                          validator: PasswordValidator.validate,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                        child: CustomTextField(
                          isPassword: true,
                          radius: 50.r,
                          keyboardtype: TextInputType.visiblePassword,
                          validator: PasswordValidator.validate,
                          label: translate("enter_new_password", context),
                          controller: authCubit.newPasswordController,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      FadeInDown(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 500),
                        child: CustomTextField(
                          isPassword: true,
                          radius: 50.r,
                          keyboardtype: TextInputType.visiblePassword,
                          validator: (value) {
                            return ConfirmPasswordValidator.validate(
                              authCubit.newPasswordController.text,
                              value,
                            );
                          },
                          label: translate("confirm_new_password", context),
                          controller: authCubit.confirmNewPasswordController,
                        ),
                      ),
                      SizedBox(height: 80.h),
                      if (state is ChangePasswordLoadingState)
                        const AppLoading()
                      else
                        BounceInDown(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 800),
                          child: CustomButton(
                            label: translate('confirm', context),
                            onPressed: () {
                              authCubit.changePassword();
                            },
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
