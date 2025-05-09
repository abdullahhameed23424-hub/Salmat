import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key, required this.onConfirm});
  final void Function() onConfirm;
  static void show(context, {required void Function() onConfirm}) {
    showDialog(
        context: context,
        builder: (context) => DeleteAccountDialog(onConfirm: onConfirm));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.LIGHTGRAY,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 40.h,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ZoomIn(
              child: Image.asset(
                Images.delete,
                width: 80.w,
              ),
            ),
            Text(
              translate("delete_account_confirmation", context),
              style: titilliumBold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    label: translate(
                        "delete", context), // Updated to use translate
                    backgroundColor: AppColors.RED,
                    size: Size(1.sw, 40.h),
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    }, // Add your delete logic here
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: CustomButton(
                    size: Size(1.sw, 40.h),
                    label: translate(
                        "cancel", context), // Updated to use translate
                    backgroundColor: AppColors.WHITE,
                    border: const BorderSide(color: AppColors.PRIMARY),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonStyle:
                        titilliumBold.copyWith(color: AppColors.PRIMARY),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
