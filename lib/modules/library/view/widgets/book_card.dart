import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/library/models/library_book.dart';
import 'package:my_project_new/widgets/cached_image.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.primaryColor, required this.book});
  final Color primaryColor;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        EasyLauncher.url(
            url: "${Urls.storageUrl}${book.file}", mode: Mode.externalApp);
      },
      child: LayoutBuilder(builder: (context, constrains) {
        return ZoomIn(
          delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
          child: Container(
            height: constrains.maxHeight,
            width: constrains.maxWidth,
            padding: EdgeInsets.all(0.w),
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: boxShadow),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      width: constrains.maxWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        book.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titilliumBold.copyWith(
                            color: AppColors.WHITE, fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      // width: 1.sw,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedImage(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          image: book.image,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
