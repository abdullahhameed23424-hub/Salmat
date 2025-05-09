import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';
import 'package:my_project_new/localization/cubit/localization_cubit.dart';
import 'package:my_project_new/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:my_project_new/modules/startup/get_started_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        context.read<LocalizationCubit>().init(context: context);

        if (AppSharedPreferences.hasToken) {
          pushAndRemoveUntiTo(context,
              toPage: BottomNavScreen(key: bottomNavScreen));
        } else {
          pushAndRemoveUntiTo(context, toPage: const GetStartedScreen());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.SECONDRY,
        body: Center(
          child: Image.asset(Images.appLogo, width: 340.w),
        ));
  }
}
