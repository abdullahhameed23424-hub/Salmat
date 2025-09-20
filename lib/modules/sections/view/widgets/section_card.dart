import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/sections/models/section.dart';
import 'package:salamat/modules/subjects/view/screens/subjects_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/cached_image.dart';

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
                child: Text(section.name,
                    style: titilliumBold.copyWith(fontSize: 16.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
            AspectRatio(
                aspectRatio: 1,
                child: CachedImage(
                    image: section.smallImage ?? section.image,
                    boxFit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(15))),
          ],
        ),
      ),
    );
  }
}
