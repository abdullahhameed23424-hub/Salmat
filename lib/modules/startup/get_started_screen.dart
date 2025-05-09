import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/auth/view/screens/login_screen.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'dart:async'; // Add this import

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController controller = PageController();
  Timer? _autoPlayTimer;
  int _currentIndex = 0;

  void _onChange(int index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer =
        Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      int nextPage = (_currentIndex + 1) % 3; // Total 3 pages
      controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 621.h,
              decoration: const BoxDecoration(color: AppColors.SECONDRY),
              child: Image.asset(Images.getStarted1, fit: BoxFit.cover),
            ),
            SizedBox(height: 65.h),
            CustomButton(
              label: translate('login_as_guest', context),
              onPressed: () {
                pushTo(context: context, toPage: const LoginScreen());
              },
              buttonStyle: titilliumBold,
              backgroundColor: AppColors.LIGHTGRAY,
            ),
            SizedBox(height: 25.h),
            CustomButton(
                label: translate('login', context),
                onPressed: () {
                  pushTo(context: context, toPage: const LoginScreen());
                }),
          ],
        ),
      ),
    );
  }
}
