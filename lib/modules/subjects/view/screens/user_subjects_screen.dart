
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/subjects/view/widgets/user_subject_cad.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class UserSubjectsScreen extends StatelessWidget {
  const UserSubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: translate('subjects', context),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: <Widget>[
              const _SubjectHeader(),
              SizedBox(height: 40.h),
              Expanded(
                child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 15.h,
                  ),
                  itemCount: 10, // عدد المواد
                  itemBuilder: (context, index) => const UserSubjectCad(),
                ),
              ),
            ],
          ),
          PositionedDirectional(
            top: 40.h,
            end: 20.w,
            child: Container(
              width: 70.w,
              height: 70.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  boxShadow: boxShadow,
                  color: AppColors.WHITE,
                  shape: BoxShape.circle),
              child: Image.asset(Images.books),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectHeader extends StatelessWidget {
  const _SubjectHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.SECONDRY),
      height: 80.h,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 0.5.sw,
            child: Text(
              translate('purchased_subjects_count', context, args: ['6']),
              style: titilliumSemiBold,
            ),
          ),
          const Spacer(),
          SizedBox(width: 120.w), // ترك مساحة للصورة اللي هتظهر بالـ Positioned
        ],
      ),
    );
  }
}
