import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/widgets/contact_row.dart';

class ContactUsLinks1 extends StatelessWidget {
  const ContactUsLinks1({super.key, required this.infoCubit});

  final InfoCubit infoCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// [CONTACT_US_TITLE]
          /// عنوان التواصل
          Text(
            'تواصل معنا الآن',
            style: titleHeader.copyWith(
              color: Colors.teal,
              decoration: TextDecoration.underline,
              decorationColor: Colors.teal,
            ),
          ),
          const SizedBox(width: 8),

          /// [WHATSAPP_LINK]
          /// رابط الواتساب
          ContactRow(
            icon: SvgPicture.asset(Images.whatsapp, width: 24.sp),
            text: '',
          ),
          const SizedBox(width: 8),

          /// [FACEBOOK_LINK]
          /// رابط الفيسبوك
          const ContactRow(
            icon: Icon(Icons.facebook, color: Colors.blue),
            text: '',
          ),
          const SizedBox(width: 8),

          /// [TELEGRAM_LINK]
          /// رابط التيليجرام
          const ContactRow(
            icon: Icon(Icons.telegram, color: AppColors.PRIMARY),
            text: '',
          ),
        ],
      ),
    );
  }
}
