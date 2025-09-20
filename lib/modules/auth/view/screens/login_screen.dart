import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/core/validators/password_validator.dart';
import 'package:salamat/core/validators/username_validator.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/modules/auth/view/widgets/create_account_sheet.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/modules/auth/view/widgets/recover_account_sheet.dart';
import 'package:salamat/modules/auth/view/widgets/row_text_button.dart';
import 'package:salamat/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/widgets/custom_textfield.dart';
import 'package:salamat/widgets/try_again.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => InfoCubit()..getInfo()),
        ],
        child: BlocBuilder<InfoCubit, InfoState>(
          builder: (context, state) {
            final infoCubit = context.read<InfoCubit>();
            if (state is GetInfoLoadingState) {
              return SizedBox(height: 1.sh, child: const AppLoading());
            }
            if (state is GetInfoErrorState) {
              return SizedBox(
                height: 1.sh,
                child: TryAgain(
                    onTap: () {
                      infoCubit.getInfo();
                    },
                    message: state.message),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const _Header(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginErrorState) {
                        customSnackBar(context,
                            success: 0, message: state.message);
                      } else if (state is LoginSuccessState) {
                        pushAndRemoveUntilTo(context,
                            toPage: const BottomNavScreen());
                      }
                    },
                    builder: (context, state) {
                      final AuthCubit authCubit = context.read<AuthCubit>();

                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: Form(
                          key: authCubit.formKey,
                          child: Column(
                            children: [
                              FadeIn(
                                delay: const Duration(milliseconds: 400),
                                child: CustomTextField(
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(
                                        authCubit.passwordFocusNode);
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
                                    ContactAdminDialog.show(context,
                                        infoCubit.infoResponse.contact.phone);
                                  },
                                  child: Text(
                                    translate("forgot_password", context),
                                    style: TextStyle(
                                        color: AppColors.SECONDRY,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              RowTextButton(
                                  transform:
                                      Matrix4.translationValues(0, -10.h, 0),
                                  title:
                                      translate('dont_have_account', context),
                                  buttonText:
                                      translate('create_account', context),
                                  onClick: () {
                                    CreateAccountSheet.show(
                                      context,
                                      onCall: () {
                                        EasyLauncher.url(
                                            url:
                                                "https://wa.me/${infoCubit.infoResponse.contact.phone}",
                                            mode: Mode.externalApp);

                                        Navigator.pop(context);
                                      },
                                    );
                                  }),
                              RowTextButton(
                                  transform:
                                      Matrix4.translationValues(0, -20.h, 0),
                                  title: translate(
                                      'account_locked_question', context),
                                  buttonText:
                                      translate('account_recovery', context),
                                  onClick: () {
                                    RecoverAccountSheet.show(
                                      context,
                                      onCall: () {
                                        EasyLauncher.url(
                                            url:
                                                "https://wa.me/${infoCubit.infoResponse.contact.phone}",
                                            mode: Mode.externalApp);

                                        Navigator.pop(context);
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

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

class ContactAdminDialog extends StatelessWidget {
  final String phoneNumber;

  const ContactAdminDialog({super.key, required this.phoneNumber});

  static Future<void> show(BuildContext context, String phoneNumber) async {
    await showDialog(
      context: context,
      builder: (context) => FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: ContactAdminDialog(phoneNumber: phoneNumber)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        translate('contact_admin_title', context),
        style: titleRegular.copyWith(color: AppColors.PRIMARY),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.admin_panel_settings,
              size: 56, color: AppColors.PRIMARY),
          const SizedBox(height: 20),
          Text(
            translate('contact_admin_message', context),
            style: titilliumRegular.copyWith(color: AppColors.BLACK),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            phoneNumber,
            style: titilliumBold.copyWith(color: AppColors.PRIMARY),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.PRIMARY,
            textStyle: titilliumSemiBold,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(translate('close', context)),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.phone, color: Colors.white),
          label: Text(
            'انقر للتواصل', // translate('call_button', context),
            style: titilliumSemiBold.copyWith(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.PRIMARY,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            shadowColor: AppColors.PRIMARY.withOpacity(0.4),
          ),
          onPressed: () {
            EasyLauncher.url(
                url: "https://wa.me/$phoneNumber", mode: Mode.externalApp);
          },
        ),
      ],
    );
  }
}
