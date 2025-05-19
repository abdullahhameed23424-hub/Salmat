import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class ContactRow extends StatelessWidget {
  final Widget icon;
  final String text;

  const ContactRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          icon,
          SizedBox(width: 5.w),
          Expanded(
            child: InkWell(
              onTap: () {
                if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(text)) {
                  EasyLauncher.email(email: text);
                } else if (RegExp(r'^[0-9]{10,15}$').hasMatch(text)) {
                  EasyLauncher.call(number: text);
                } else {
                  EasyLauncher.url(url: text);
                }
              },
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titilliumRegular.copyWith(
                  color: AppColors.PRIMARY,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.PRIMARY,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
