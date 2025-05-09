// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class ResendEmail extends StatefulWidget {
  const ResendEmail({super.key, required this.onTap});

  final void Function() onTap;
  @override
  _ResendEmailState createState() => _ResendEmailState();
}

class _ResendEmailState extends State<ResendEmail> {
  int seconds = 59;
  bool buttonActivate = false;
  Timer? _timer;

  @override
  void initState() {
    resend();

    super.initState();
  }

  void resend() {
    buttonActivate = false;
    if (mounted) setState(() {});

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          if (mounted) setState(() {});
        } else if (seconds == 0) {
          seconds = 59;
          _timer?.cancel();
          buttonActivate = true;
          if (mounted) setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonActivate
          ? () {
              resend();

              widget.onTap();
            }
          : null,
      child: Text(buttonActivate ? 'إعادة إرسال' : " انتظر $seconds ثانية",
          style: titleRegular.copyWith(
              color: AppColors.PRIMARY,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.SECONDRY)),
    );
  }
}
