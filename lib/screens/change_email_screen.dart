// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/utils/global_functions.dart';

import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/core/validators/email_validator.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/custom_textfield.dart';
import 'package:my_project_new/widgets/otp_field.dart';
import 'package:my_project_new/widgets/resend_email.dart';
// to doo test screen

class ChangeEmaliScreen extends StatelessWidget {
  const ChangeEmaliScreen({
    super.key,
    required this.emailController,
  });
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('update_email', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35.h),
              Text(
                translate('update_email', context),
                style: titilliumBold,
              ),
              SizedBox(height: 10.h),
              BlocProvider(
                create: (context) => AuthCubit(),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) async {
                    final AuthCubit authCubit = context.read<AuthCubit>();

                    if (state is UpdateEmailErrorState) {
                      customSnackBar(
                            context,
                          success: -1,
                          message: state.message);
                    } else if (state is UpdateEmailSuccessState) {
                      emailController.text = state.email;
                      Navigator.of(context).pop();
                    } else if (state is GetCodeSuccessState) {
                      authCubit.codeSent = true;
                      customSnackBar(
                            context,
                          success: 1,
                          message:
                              translate('code_sent_successfully', context));
                    } else if (state is GetCodeErrorState) {
                      customSnackBar(
                            context, success: 0, message: state.message);
                    } else if (state is CheckCodeErrorState) {
                      customSnackBar(
                            context, success: 0, message: state.message);
                    }
                  },
                  builder: (context, state) {
                    final AuthCubit authCubit = context.read<AuthCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Form(
                              key: authCubit.emailFormKey,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      keyboardtype: TextInputType.emailAddress,
                                      readOnly: authCubit.codeSent ||
                                          state is GetCodeLoadingState,
                                      enabled: !authCubit.isEmailVerified,
                                      focusNode: authCubit.emailFocusNode,
                                      validator: EmailValidator.validate,
                                      label:
                                          translate('email_address', context),
                                      controller: authCubit.emailController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  if (authCubit.codeSent)
                                    MaterialButton(
                                      padding: EdgeInsets.all(1.w),
                                      height: 44.h,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      onPressed: () {
                                        authCubit.changeVerifiedEmail();
                                      },
                                      color: AppColors.PRIMARY,
                                      child: Text(translate("change", context),
                                          style: titilliumBold.copyWith(
                                              color: Colors.white)),
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Builder(
                              builder: (context) {
                                if (authCubit.codeSent) {
                                  return const SizedBox();
                                }

                                if (state is GetCodeLoadingState) {
                                  return Padding(
                                    padding: EdgeInsets.all(15.w),
                                    child: const AppLoading(),
                                  );
                                }

                                return Padding(
                                  padding: EdgeInsets.only(top: 25.h),
                                  child: MaterialButton(
                                    padding: EdgeInsets.all(4.w),
                                    height: 40.h,
                                    minWidth: 250.w,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    onPressed: () {
                                      if (!authCubit.isEmailVerified) {
                                        if (authCubit.emailFormKey.currentState!
                                            .validate()) {
                                          authCubit.getVerificationCode(
                                              email: authCubit
                                                  .emailController.text,
                                              task: "reset_email");
                                        }
                                      } else {
                                        authCubit.updateEmail();
                                      }
                                    },
                                    color: AppColors.PRIMARY,
                                    child: Text(
                                      translate('verify', context),
                                      style: titilliumBold.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Visibility(
                          visible: authCubit.codeSent,
                          child: FadeInUp(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: OtpField(
                                        state: state,
                                        task: "reset_email",
                                        onCompleted: (value) {
                                          authCubit.updateEmail();
                                        },
                                        email: authCubit.emailController.text,
                                        authCubit: authCubit),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      translate('didnt_receive_code', context),
                                      style: titilliumRegular,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ResendEmail(
                                      onTap: () {
                                        authCubit.getVerificationCode(
                                          task: "reset_email",
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Builder(
                          builder: (context) {
                            if (state is UpdateEmailLoadingState) {
                              return const AppLoading();
                            }
                            if (authCubit.codeSent) {
                              return CustomButton(
                                label: translate('save', context),
                                onPressed: () {
                                  if (authCubit.otpController.text.length < 6) {
                                    customSnackBar(
                                          context,
                                        success: 2,
                                        message: translate(
                                            'please_enter_code', context));
                                  } else {
                                    authCubit.updateEmail();
                                  }
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
