import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/try_again.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.authCubit});
  final AuthCubit authCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: BlocProvider.value(
        value: authCubit,
        child: BlocBuilder<AuthCubit, AuthState>(
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
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: boxShadow,
                          color: AppColors.WHITE,
                        ),
                        child: CachedImage(
                          image: authCubit.user.image,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(authCubit.user.fullName,
                          style: titilliumBold.copyWith(
                              fontSize: 20.sp, color: AppColors.WHITE)),
                      SizedBox(height: 8.h),
                      Text(authCubit.user.grade?.name ?? "",
                          style: titilliumBold.copyWith(fontSize: 20.sp)),
                      SizedBox(height: 54.h),
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
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Text(translate('other_info_title', context),
                    style: titilliumBold.copyWith(
                        decoration: TextDecoration.underline)),
                const SizedBox(height: 10),
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
