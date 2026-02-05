// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';

class SkipExamConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const SkipExamConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => SkipExamConfirmationDialog(
        title: title,
        message: message,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        message,
        style: titilliumRegular.copyWith(
            color: AppColors.DARK_GRAY, fontSize: 16.sp),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            translate('cancel', context),
            style: titilliumBold,
          ),
        ),
        FilledButton(
          onPressed: onConfirm,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.PURPLE_LIGHT,
          ),
          child: Text(
            translate('skip_exam', context),
            style: titilliumBold.copyWith(color: AppColors.WHITE),
          ),
        ),
      ],
    );
  }
}

class StartExamConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const StartExamConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => StartExamConfirmationDialog(
        title: title,
        message: message,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        message,
        style: titilliumRegular.copyWith(
            color: AppColors.DARK_GRAY, fontSize: 16.sp),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            translate('cancel', context),
            style: titilliumBold,
          ),
        ),
        FilledButton(
          onPressed: onConfirm,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.PRIMARY,
          ),
          child: Text(
            translate('confirm', context),
            style: titilliumBold.copyWith(color: AppColors.WHITE),
          ),
        ),
      ],
    );
  }
}
