import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/video/models/my_viedeo.dart';

class ResolutionCard extends StatelessWidget {
  const ResolutionCard({
    super.key,
    required this.video
  });
  final MyVideo video;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 400),
      delay: Duration(milliseconds: 100 * (1 + Random().nextInt(7))),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            color: AppColors.LIGHTGRAY,
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${video.quality}P', style: titilliumBold),
            SizedBox(width: 3.w),
            Image.asset(
              Images.downloadArrow,
              width: 25.w,
            ),
          ],
        ),
      ),
    );
  }
}
