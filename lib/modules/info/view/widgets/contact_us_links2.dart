import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/widgets/contact_row.dart';

class ContactUsLinks2 extends StatelessWidget {
  const ContactUsLinks2({super.key, required this.infoCubit});

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

          SizedBox(height: 5.h),

          /// [INSTAGRAM_LINK]
          /// رابط الانستجرام
          ContactRow(
            icon: SvgPicture.asset(Images.insta, width: 24.sp),
            text: '',
          ),
          const SizedBox(width: 8),

          /// [LINKEDIN_LINK]
          /// رابط اللينكد
          ContactRow(
            icon: SvgPicture.asset(
              Images.linkedin,
              width: 24.sp,
            ),
            text: '',
          ),
          const SizedBox(width: 8),

          /// [YOUTUBE_LINK]
          /// رابط اليوتيوب
          ContactRow(
            icon: SvgPicture.asset(
              Images.youtube,
              width: 24.sp,
            ),
            text: '',
          ),
        ],
      ),
    );
  }
}
