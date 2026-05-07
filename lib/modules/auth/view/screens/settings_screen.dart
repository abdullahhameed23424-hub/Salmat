import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/modules/auth/view/screens/change_password_screen.dart';
import 'package:salamat/modules/auth/view/widgets/delete_account_dialog.dart';
import 'package:salamat/modules/startup/view/screen/get_started_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/widgets/modern_loading_dialog.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final GlobalKey<ModernLoadingDialogState> loadingDialogKey =
      GlobalKey<ModernLoadingDialogState>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: translate('settings', context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogoutLoadingState) {
                  ModernLoadingDialog.show(context, loadingDialogKey);
                }
                if (state is LogoutSuccessState) {
                  if (loadingDialogKey.currentState != null) {
                    Navigator.pop(context);
                  }
                  AppSharedPreferences.removeToken;
                  pushAndRemoveUntilTo(context,
                      toPage: const GetStartedScreen());
                }
                if (state is LogoutErrorState) {
                  customSnackBar(context, success: 0, message: state.message);
                }
              },
              builder: (context, state) {
                final AuthCubit authCubit = context.read<AuthCubit>();
                return Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 30.h),
                        _CustomListTile(
                            iconData: Icons.keyboard,
                            onTap: () {
                              pushTo(
                                  context: context,
                                  toPage: const ChangePasswordScreen());
                            },
                            title: translate('change_password', context)),
                        _CustomListTile(
                            iconData: Icons.delete_outline,
                            onTap: () {
                              DeleteAccountDialog.show(
                                context,
                                onConfirm: () {
                                  authCubit.logout(); // also logout
                                },
                              );
                            },
                            title: translate('delete_account', context)),
                        _CustomListTile(
                            iconData: Icons.logout,
                            onTap: () {
                              LogoutDialog.show(
                                context,
                                onConfirm: () {
                                  authCubit.logout();
                                },
                              );
                            },
                            title: translate("logout", context)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Spacer(),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(Images.settings, width: 360.w))
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.iconData,
    required this.title,
    required this.onTap,
  });
  final IconData iconData;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: titilliumBold),
        leading: Icon(iconData, color: AppColors.PRIMARY),
        shape: const Border(
            bottom: BorderSide(color: AppColors.PRIMARY, width: 1.5)),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, required this.onConfirm});
  final void Function() onConfirm;

  static void show(context, {required void Function() onConfirm}) {
    showDialog(
        context: context,
        builder: (context) => LogoutDialog(onConfirm: onConfirm));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.LIGHTGRAY,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 40.h,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ZoomIn(
              child: Image.asset(
                Images.logout,
                width: 80.w,
              ),
            ),
            Text(
              translate("logout_confirmation", context),
              style: titilliumBold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    label:
                        translate("yes", context), // Updated to use translate
                    backgroundColor: AppColors.PRIMARY,
                    size: Size(1.sw, 40.h),
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    }, // Add your delete logic here
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: CustomButton(
                    size: Size(1.sw, 40.h),
                    label: translate(
                        "cancel", context), // Updated to use translate
                    backgroundColor: AppColors.WHITE,
                    border: const BorderSide(color: AppColors.PRIMARY),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonStyle:
                        titilliumBold.copyWith(color: AppColors.PRIMARY),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
