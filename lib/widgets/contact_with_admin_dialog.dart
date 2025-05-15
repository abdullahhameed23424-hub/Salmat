import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';

class ContactWithAdminDialog extends StatelessWidget {
  const ContactWithAdminDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 16.h),
            child: Text(
              translate(
                  'contact_admin_to_buy', context),
              style: titilliumRegular,
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                translate("tap_to_contact", context),
                style: titilliumBold.copyWith(
                    decoration:
                        TextDecoration.underline),
              )),
          const Spacer(),
          Image.asset(
            Images.contactWhatsapp,
            width: 1.sw,
          )
        ],
      ),
    );
  }
}
