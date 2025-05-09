import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/read_more_text.dart';

class CommentCard extends StatelessWidget {
  final Map<String, dynamic> comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 75.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: boxShadow,
              color: Colors.white,
              border: Border.all(color: AppColors.GRAY600, width: 2)),
          child: Image.asset(Images.trainer),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey.shade400,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment['name'],
                  style: titilliumBold,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8.h),
                // Text(
                //   comment['comment'],
                //   textDirection: TextDirection.rtl,
                //   style: titilliumSemiBold,
                // ),

                ReadMoreText(
                  text: comment['comment'] * 8,
                  maxLength: 100,
                ),

                SizedBox(height: 12.h),
                Text(
                  'عرض الردود',
                  style: titilliumRegular.copyWith(color: AppColors.GRAY600),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Icon(Icons.thumb_down_outlined, size: 28.sp),
                    SizedBox(width: 10.w),
                    Icon(Icons.thumb_up_outlined, size: 28.sp),
                    const Spacer(),
                    SizedBox(width: 10.w),
                    Text('${comment['likes']}  ${translate('likes', context)}',
                        style: titilliumRegular.copyWith(
                          color: AppColors.GRAY500,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
