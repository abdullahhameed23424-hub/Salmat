import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/sections/models/section.dart';
import 'package:salamat/modules/subjects/view/screens/subjects_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/cached_image.dart';

class HomeSectionCard extends StatelessWidget {
  const HomeSectionCard({
    super.key,
    required this.section,
  });
  final Section section;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: SubjectsScreen(section: section));
      },
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(14.h),
              decoration: BoxDecoration(
                  boxShadow: boxShadow,
                  color: AppColors.GRAY,
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.5.h),
              width: 185.w,
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 120.w,
                    height: 115.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.SECONDRY.withAlpha(100)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedImage(
                        image: section.smallImage ?? section.image ,
                        height: 100.h,
                      ),
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    section.name,
                    style: titilliumBold.copyWith(fontSize: 14.sp),
                  )
                ],
              )),
          Positioned(
              left: 0,
              top: (200.h / 2) - (22.5.h),
              child: Container(
                height: 45.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  border: BorderDirectional(
                      start: BorderSide(color: Colors.black26)),
                  color: Colors.white,
                ),
                child: Container(
                    transform: Matrix4.translationValues(1.w, 0, 0),
                    decoration: BoxDecoration(
                        boxShadow: boxShadow,
                        color: AppColors.SECONDRY,
                        shape: BoxShape.circle),
                    child: Transform.rotate(
                        angle: 0.7,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 25.sp,
                          color: Colors.white,
                        ))),
              ))
        ],
      ),
    );
  }
}
