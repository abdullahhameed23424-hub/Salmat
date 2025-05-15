import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

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
          child: AspectRatio(
              aspectRatio: 1,
              child: CachedImage(
                image: comment.user.image,
                boxFit: BoxFit.cover,
              )),
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
                  comment.user.username,
                  style: titilliumBold,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(comment.createdAt),
                    style: titilliumRegular.copyWith(fontSize: 10.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                ReadMoreText(
                  text: comment.body,
                  maxLength: 100,
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
