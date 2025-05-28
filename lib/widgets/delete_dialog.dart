import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });
  final String title;
  final String content;
  final void Function() onConfirm;

  static show(BuildContext context,
      {required String title,
      required String content,
      required void Function() onConfirm}) {
    showDialog(
      context: context,
      builder: (
        context,
      ) =>
          DeleteDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(title, style: titilliumBold.copyWith(fontSize: 20.sp)),
      content: Text(content, style: titilliumRegular.copyWith(fontSize: 16.sp)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(translate("cancel", context), style: titilliumBold),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(true);
          },
          child: Text(translate("delete", context),
              style: titilliumBold.copyWith(color: Colors.red)),
        ),
      ],
    );
  }
}
