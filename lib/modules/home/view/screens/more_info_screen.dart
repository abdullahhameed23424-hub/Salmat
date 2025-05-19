import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/auth/cubit/auth_cubit.dart';
import 'package:my_project_new/modules/auth/view/screens/profile_screen.dart';
import 'package:my_project_new/modules/auth/view/screens/settings_screen.dart';
import 'package:my_project_new/modules/info/cubit/info_cubit.dart';
import 'package:my_project_new/modules/info/view/screens/contact_us_screen.dart';
import 'package:my_project_new/modules/test/view/screens/completed_tests_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/modules/info/view/screens/about_us_screen.dart';
import 'package:my_project_new/modules/info/view/screens/privacy_policy_screen.dart';
import 'package:my_project_new/modules/library/view/screens/library_screen.dart';
import 'package:my_project_new/modules/points_record/view/screens/points_record_screen.dart';
import 'package:my_project_new/modules/subjects/view/screens/user_subjects_screen.dart';
import 'package:my_project_new/modules/teachers/view/screens/teachers_screen.dart';

class MoreInfoScreen extends StatelessWidget {
  MoreInfoScreen({super.key});

  static final InfoCubit infoCubit = InfoCubit();
  
  // we declare the infoCubit as static to use it in all the screens to call the api once

  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.person_outline_outlined,
      "title": "my_info",
      "onTap": (BuildContext context) {
        pushTo(
            context: context,
            toPage: ProfileScreen(
              authCubit: AuthCubit()..getProfile(),
            ));
      }
    },
    {
      "icon": Icons.subject,
      "title": "my_subjects",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const UserSubjectsScreen());
      }
    },
    {
      "image": Images.pointsIcon,
      "title": "my_points",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const PointsRecordScreen());
      }
    },
    {
      "icon": Icons.download_outlined,
      "title": "downloaded_lessons",
      "onTap": (BuildContext context) {
        // pushTo(context: context, toPage: const PointsRecordScreen());
      }
    },
    {
      "image": Images.libraryIcon,
      "title": "library",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const LibraryScreen());
      }
    },
    {
      "image": Images.testIcon,
      "title": "completed_tests",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const CompletedTestsScreen());
      }
    },
    {
      "image": Images.trainersIcon,
      "title": "teachers",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const TeachersScreen());
      }
    },
    {
      "image": Images.settingsIcon,
      "title": "settings",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: SettingsScreen());
      }
    },
    {
      "image": Images.privacyPolicy,
      "title": "privacy_policy",
      "onTap": (BuildContext context) {
        pushTo(
            context: context,
            toPage: PrivacyPolicyScreen(infoCubit: infoCubit));
      }
    },
    {
      "icon": Icons.call,
      "title": "contact_us",
      "onTap": (BuildContext context) {
        pushTo(
            context: context, toPage: ContactInfoScreen(infoCubit: infoCubit));
      }
    },
    {
      "image": Images.aboutUs,
      "title": "about_us",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: AboutUsScreen(infoCubit: infoCubit));
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0, -3.h, 0),
            color: AppColors.SECONDRY,
            height: 80.h,
            width: 1.sw,
          ),
          Container(
            transform: Matrix4.translationValues(0, -70.h, 0),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            decoration: BoxDecoration(
                color: AppColors.WHITE,
                boxShadow: boxShadow,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
                children: List.generate(
              menuItems.length,
              (index) => Column(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        menuItems[index]['onTap'](context);
                      },
                      title: Text(translate(menuItems[index]['title'], context),
                          style: titilliumBold),
                      leading: menuItems[index]['image'] != null
                          ? Image.asset(
                              menuItems[index]['image'],
                              height: 35.h,
                            )
                          : Icon(
                              menuItems[index]['icon'],
                              color: AppColors.PRIMARY,
                              size: 35.sp,
                            ),
                    ),
                  ),
                  if (index != menuItems.length - 1)
                    Divider(
                        indent: 0.1.sw,
                        endIndent: 0.1.sw,
                        height: 12.h,
                        color: AppColors.GRAY)
                ],
              ),
            )),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
