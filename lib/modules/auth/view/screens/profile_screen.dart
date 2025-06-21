import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/cached_image.dart';
import 'package:salamat/widgets/image_viewer.dart';
import 'package:salamat/widgets/modern_loading_dialog.dart';
import 'package:salamat/widgets/pick_image_dialog.dart';
import 'package:salamat/widgets/try_again.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.authCubit});
  final AuthCubit authCubit;
  final GlobalKey<ModernLoadingDialogState> loadingKey =
      GlobalKey<ModernLoadingDialogState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: BlocProvider.value(
        value: authCubit, //..getProfile(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is EditProfileLoadingState) {
              ModernLoadingDialog.show(context, loadingKey);
            } else if (state is EditProfileSuccessState) {
              if (loadingKey.currentState != null) {
                Navigator.pop(context);
              }
              authCubit.getProfile();
            } else if (state is EditProfileErrorState) {
              if (loadingKey.currentState != null) {
                Navigator.pop(context);
              }
              customSnackBar(context, success: 0, message: state.message);
            }
          },
          builder: (context, state) {
            final AuthCubit authCubit = context.read<AuthCubit>();
            if (state is GetProfileLoadingState) {
              return const AppLoading();
            }
            if (state is GetCodeErrorState) {
              return TryAgain(
                  onTap: () {
                    authCubit.getProfile();
                  },
                  message: state.message);
            }
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.SECONDRY,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: () {
                              pushTo(
                                  context: context,
                                  toPage: ImageViewer(
                                      imageUrl: authCubit.user.image));
                            },
                            child: Container(
                              width: 130.w,
                              height: 130.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: boxShadow,
                                  color: AppColors.WHITE),
                              child: CachedImage(
                                image: authCubit.user.image,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -3,
                            left: -3,
                            child: IconButton(
                                style: IconButton.styleFrom(
                                    backgroundColor:
                                        AppColors.WHITE.withAlpha(120)),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => PickImageDialog(
                                      onSelect: ({required imageSource}) {
                                        authCubit.pickImage(
                                            imageSource: imageSource);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.LOGO_PRIMARY,
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(authCubit.user.fullName,
                          style: titilliumBold.copyWith(
                              fontSize: 20.sp, color: AppColors.WHITE)),
                      SizedBox(height: 8.h),
                      Text(authCubit.user.grade?.name ?? "",
                          style: titilliumBold.copyWith(fontSize: 20.sp)),
                      SizedBox(height: 48.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileInfo(
                              title: translate("dob_label", context),
                              value: authCubit.user.birthday),
                          _Divider(),
                          ProfileInfo(
                              title: translate('address_label', context),
                              value: authCubit.user.city?.name ?? ""),
                          _Divider(),
                          ProfileInfo(
                              title: translate('phone_label', context),
                              value: authCubit.user.phoneNumber),
                        ],
                      ),
                      SizedBox(height: 45.h),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                Text(translate('other_info_title', context),
                    style: titilliumBold.copyWith(
                        decoration: TextDecoration.underline)),
                const SizedBox(height: 10),
                InfoCard(
                    title: translate('username', context),
                    value: authCubit.user.username),
                InfoCard(
                    title: translate('father_name_label', context),
                    value: authCubit.user.fatherName),
                InfoCard(
                    title: translate('mother_name_label', context),
                    value: authCubit.user.motherName),
                InfoCard(
                    title: translate('guardian_phone_label', context),
                    value: authCubit.user.familyPhoneNumber),
                const Spacer(),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(Images.bottomProfile, height: 80.w),
                      const Spacer(),
                      Image.asset(Images.profileScreen, height: 100),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.DARK_GREY, height: 40.h, width: 1.w);
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String value;
  const ProfileInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 5,
        children: [
          Text(title,
              style: titleRegular.copyWith(
                  color: AppColors.WHITE, fontSize: 12.sp)),
          Text(
            value,
            textAlign: TextAlign.center,
            style: titleRegular.copyWith(color: AppColors.WHITE),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: AppColors.LIGHTGRAY,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.SECONDRY,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      bottomStart: Radius.circular(10))),
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
              ),
              child: Text(title,
                  style: titilliumBold.copyWith(
                      color: AppColors.WHITE, fontSize: 14.sp)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.LIGHTGRAY,
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(10),
                      bottomEnd: Radius.circular(10))),
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
              ),
              child:
                  Text(value, style: titilliumBold.copyWith(fontSize: 14.sp)),
            ),
          )
        ],
      ),
    );
  }
}
