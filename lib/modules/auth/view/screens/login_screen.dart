import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/core/validators/password_validator.dart';
import 'package:my_project_new/core/validators/username_validator.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/modules/auth/view/widgets/create_account_sheet.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/modules/auth/view/widgets/recover_account_sheet.dart';
import 'package:my_project_new/modules/auth/view/widgets/row_text_button.dart';
import 'package:my_project_new/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: Column(
            children: [
              const _Header(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginErrorState) {
                    customSnackBar(context, success: 0, message: state.message);
                  } else if (state is LoginSuccessState) {
                    pushAndRemoveUntiTo(context,
                        toPage: BottomNavScreen(
                    
                        ));
                  }
                },
                builder: (context, state) {
                  final AuthCubit authCubit = context.read<AuthCubit>();

                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Form(
                      key: authCubit.formKey,
                      child: Column(
                        children: [
                          FadeIn(
                            delay: const Duration(milliseconds: 400),
                            child: CustomTextField(
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(authCubit.passwordFocusNode);
                              },
                              controller: authCubit.userNameController,
                              validator: UsernameValidator.validate,
                              label: translate("username", context),
                              keyboardtype: TextInputType.name,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          FadeIn(
                            delay: const Duration(milliseconds: 600),
                            child: CustomTextField(
                              focusNode: authCubit.passwordFocusNode,
                              onFieldSubmitted: (_) {
                                authCubit.login();
                              },
                              isPassword: true,
                              validator: PasswordValidator.validate,
                              controller: authCubit.passwordController,
                              label: translate("password", context),
                              keyboardtype: TextInputType.visiblePassword,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          if (state is LoginLoadingState)
                            const AppLoading()
                          else
                            FadeIn(
                              delay: const Duration(milliseconds: 800),
                              child: CustomButton(
                                label: translate("login", context),
                                onPressed: () {
                                  authCubit.login();
                                },
                              ),
                            ),
                          SizedBox(height: 10.h),
                          FadeIn(
                            delay: const Duration(milliseconds: 900),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                          
                              },
                              child: Text(
                                translate("forgot_password", context),
                                style: TextStyle(
                                    color: AppColors.SECONDRY, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          RowTextButton(
                              transform: Matrix4.translationValues(
                                  0, -10.h, 0),  
                              title: translate('dont_have_account', context),
                              buttonText: translate('create_account', context),
                              onClick: () {
                                CreateAccountSheet.show(context);
                              }),
                          RowTextButton(
                              transform: Matrix4.translationValues(0, -20.h, 0),
                              title:
                                  translate('account_locked_question', context),
                              buttonText:
                                  translate('account_recovery', context),
                              onClick: () {
                                RecoverAccountSheet.show(context);
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Image.asset(Images.loginTopImage,
                fit: BoxFit.cover, width: 280.w)),
        FadeInUp(
          delay: const Duration(milliseconds: 300),
          child: Column(
            children: [
              Image.asset(Images.loginMaleLogoImage, height: 145.h),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(translate("login_description", context),
                    textAlign: TextAlign.center, style: titilliumSemiBold),
              ),
              SizedBox(height: 10.h),
              Text(translate("login_now", context),
                  style: titilliumBold.copyWith(
                    color: AppColors.SECONDRY,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
