import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';

class CreateAccountSheet extends StatelessWidget {
  const CreateAccountSheet({super.key, required this.onCall});
  final void Function() onCall;
  static void show(context, {required void Function() onCall}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0Xff67ACCB),
      context: context,
      builder: (context) {
        return CreateAccountSheet(onCall: onCall);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: Column(
        children: <Widget>[
          Image.asset(Images.appLogo, width: 158.w),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                translate('welcome_salamat', context),
                style: titilliumBold.copyWith(color: AppColors.WHITE),
                textAlign: TextAlign.center,
              )),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Positioned(
                  right: 0,
                  child: Image.asset(Images.createAccount,
                      width: 260.w, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 0,
                  child: FadeInUp(
                      child:
                          Image.asset(Images.wihteContactDialog, width: 170.w)),
                ),
                Positioned(
                    left: 0,
                    bottom: 134.h,
                    child: InkWell(
                      onTap: onCall,
                      child: SizedBox(width: 145.w, height: 105.h),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
