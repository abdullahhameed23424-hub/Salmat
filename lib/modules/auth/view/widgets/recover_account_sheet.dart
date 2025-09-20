import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/localization/language_constrants.dart';

class RecoverAccountSheet extends StatelessWidget {
  const RecoverAccountSheet({super.key, required this.onCall});
  final void Function() onCall;

  static void show(context, {required void Function() onCall}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return RecoverAccountSheet(onCall: onCall);
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
              child: Text(translate('recovery_message', context),
                  style: titilliumBold.copyWith(color: AppColors.BLACK),
                  textAlign: TextAlign.center)),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  left: 0,
                  child: Image.asset(Images.recoverAccount,
                      width: 240.w, fit: BoxFit.cover),
                ),
                Positioned(
                    right: 5.w,
                    bottom: 0,
                    child: ZoomIn(
                        child: Image.asset(Images.blueContactDialog,
                            width: 150.w))),
                Positioned(
                    right: 5.w,
                    bottom: 130.h,
                    child: InkWell(
                      onTap: onCall,
                      child: SizedBox(width: 145.w, height: 110.h),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
