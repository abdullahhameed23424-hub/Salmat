import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/sections/models/section.dart';
import 'package:my_project_new/modules/subjects/view/screens/subjects_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/cached_image.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.section,
    required this.index,
  });
  final Section section;
  final int index; // only for color
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: SubjectsScreen(section: section));
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 400.w,
        height: 138.h,
        decoration: BoxDecoration(
            boxShadow: boxShadow,
            color: index.isEven ? AppColors.DARK_GREY : AppColors.SECONDRY,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          spacing: 5.w,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: BoxDecoration(
                    color: index.isEven ? AppColors.SECONDRY : Colors.white10,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(Images.classIcon, width: 30.w)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name,
                    style: titilliumBold.copyWith(fontSize: 18.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
            ),
            AspectRatio(
                aspectRatio: 1,
                child: CachedImage(
                    image: section.image,
                    boxFit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(5))),
          ],
        ),
      ),
    );
  }
}
