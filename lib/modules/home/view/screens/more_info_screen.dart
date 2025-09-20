import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/animation/fade_in_animation.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/auth/cubit/auth_cubit.dart';
import 'package:salamat/modules/auth/view/screens/profile_screen.dart';
import 'package:salamat/modules/auth/view/screens/settings_screen.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/screens/contact_us_screen.dart';
import 'package:salamat/modules/startup/get_started_screen.dart';
import 'package:salamat/modules/test/view/screens/completed_tests_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/modules/info/view/screens/about_us_screen.dart';
import 'package:salamat/modules/info/view/screens/privacy_policy_screen.dart';
import 'package:salamat/modules/library/view/screens/library_screen.dart';
import 'package:salamat/modules/points_record/view/screens/points_record_screen.dart';
import 'package:salamat/modules/courses/view/screens/my_courses_screen.dart';
import 'package:salamat/modules/teachers/view/screens/teachers_screen.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/try_again.dart';

import '../../../downloads/materials/downloaded_material_cubit.dart';
import '../../../downloads/materials/downloaded_material_screen.dart';

class MoreInfoScreen extends StatelessWidget {
  MoreInfoScreen({super.key});

  static final InfoCubit infoCubit = InfoCubit();

  // we declare the infoCubit as static to use it in all the screens to call the api once

  final List<Map<String, dynamic>> menuItems = [
    if (!AppSharedPreferences.hasToken)
      {
        "icon": Icons.login_outlined,
        "title": "login",
        "onTap": (BuildContext context) {
          pushAndRemoveUntilTo(context, toPage: const GetStartedScreen());
        }
      },
    if (AppSharedPreferences.hasToken)
      {
        "icon": Icons.person_outline_outlined,
        "title": "profile",
        "onTap": (BuildContext context) {
          pushTo(context: context, toPage: ProfileScreen());
        }
      },
    if (AppSharedPreferences.hasToken)
      {
        "icon": Icons.play_lesson,
        "title":
            "my_subjects", // app owner wants its name my_subjects but it is Courses screen
        "onTap": (BuildContext context) {
          pushTo(context: context, toPage: const MyCoursesScreen());
        }
      },
    if (AppSharedPreferences.hasToken)
      {
        "image": Images.pointsIcon,
        "title": "my_points",
        "onTap": (BuildContext context) {
          pushTo(context: context, toPage: const PointsRecordScreen());
        }
      },
    if (AppSharedPreferences.hasToken)
      {
        "icon": Icons.download_outlined,
        "title": "downloaded_lessons",
        "onTap": (BuildContext context) {
          pushTo(
              context: context,
              toPage: const DownloadedMaterialScreen(
                title: 'موادي',
                type: DownloadedMaterialType.subject,
              ));
        }
      },
    {
      "image": Images.libraryIcon,
      "title": "library",
      "onTap": (BuildContext context) {
        pushTo(context: context, toPage: const LibraryScreen());
      }
    },
    if (AppSharedPreferences.hasToken)
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
    if (AppSharedPreferences.hasToken)
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
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

class ContactAdminDialog extends StatelessWidget {
  const ContactAdminDialog({super.key});

  static Future<void> show(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: const ContactAdminDialog()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: BlocProvider(
          create: (context) => InfoCubit()..getInfo(),
          child: BlocBuilder<InfoCubit, InfoState>(
            builder: (context, state) {
              final InfoCubit infoCubit = context.read<InfoCubit>();
              if (state is GetInfoLoadingState) {
                return SizedBox(height: 0.3.sh, child: const AppLoading());
              }
              if (state is GetInfoErrorState) {
                return SizedBox(
                  height: 0.3.sh,
                  child: TryAgain(
                      small: true,
                      withImage: true,
                      onTap: () {
                        infoCubit.getInfo();
                      },
                      message: state.message),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      translate('contact_admin_title', context),
                      style: titleRegular.copyWith(color: AppColors.PRIMARY),
                    ),
                    const Icon(Icons.admin_panel_settings_outlined,
                        size: 56, color: AppColors.PRIMARY),
                    const SizedBox(height: 20),
                    Text(
                      translate('contact_admin_message', context),
                      style: titilliumRegular.copyWith(color: AppColors.BLACK),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      infoCubit.infoResponse.contact.phone,
                      style: titilliumBold.copyWith(color: AppColors.PRIMARY),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.PRIMARY,
                            textStyle: titilliumSemiBold,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(translate('close', context)),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.phone, color: Colors.white),
                          label: Text(
                            translate('call_button', context),
                            style:
                                titilliumSemiBold.copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.PRIMARY,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            shadowColor: AppColors.PRIMARY.withOpacity(0.4),
                          ),
                          onPressed: () {
                            final phoneNumber =
                                infoCubit.infoResponse.contact.phone;
                            if (RegExp(r'^[0-9]{10,15}$')
                                .hasMatch(phoneNumber)) {
                              EasyLauncher.call(number: phoneNumber);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
