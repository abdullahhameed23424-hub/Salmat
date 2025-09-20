import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/cubit/localization_cubit.dart';
import 'package:salamat/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:salamat/modules/startup/get_started_screen.dart';
import 'package:salamat/utils/global_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        context.read<LocalizationCubit>().init(context: context);

        if (AppSharedPreferences.hasToken || AppSharedPreferences.isGuest) {
          pushAndRemoveUntilTo(context, toPage: const BottomNavScreen());
        } else {
          pushAndRemoveUntilTo(context, toPage: const GetStartedScreen());
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.SECONDRY,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.SECONDRY,
        systemNavigationBarIconBrightness: Brightness.light

        // iOS
        ));
    return Scaffold(
        backgroundColor: AppColors.SECONDRY,
        body: Center(
          child: Image.asset(Images.appLogo, width: 340.w),
        ));
  }
}
