import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/auth/view/screens/login_screen.dart';
import 'package:salamat/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:salamat/modules/startup/view/widget/share_app_btn.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/utils/global_functions.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: Column(
        children: <Widget>[
          /// [SCREEN_BASE_IMAGE]
          Expanded(
            child: Container(
              width: 1.sw,
              decoration: const BoxDecoration(color: AppColors.SECONDRY),
              child: Image.asset(Images.getStarted1, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 65.h),

          /// [LOGIN_BUTTON]
          CustomButton(
            label: translate('login', context),
            onPressed: () {
              pushTo(context: context, toPage: const LoginScreen());
            },
          ),
          SizedBox(height: 25.h),

          /// [LOGIN_AS_GUEST_BUTTON]
          CustomButton(
            label: translate('login_as_guest', context),
            onPressed: () {
              AppSharedPreferences.saveGuest('true');
              pushTo(context: context, toPage: const BottomNavScreen());
            },
            buttonStyle: titilliumBold,
            backgroundColor: AppColors.LIGHTGRAY,
          ),
          SizedBox(height: 25.h),

          /// [SHARE_APP_BUTTON]
          const ShareAppBtn(),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
