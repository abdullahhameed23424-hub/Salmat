import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; 
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/points_record/models/points.dart';
import 'package:my_project_new/modules/points_record/view/widgets/text_row.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({
    super.key,
    required this.points,
  });
  final Points points;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 50 + 100 * Random().nextInt(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: boxShadow,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 1.sw,
                    ),
                    TextRow(
                        title: "${translate('points', context)}:",
                        value: points.points.toString()),
                    TextRow(
                      title: "${translate('time', context)}:",
                      value:
                          " ${DateFormat('hh:MM a').format(points.createdAt)} ",
                    ),
                    TextRow(
                        title: "${translate('reason', context)}:",
                        value: points.reason),
                  ],
                ),
              ),
              PositionedDirectional(
                  top: -20.h,
                  end: 40.w,
                  child: Image.asset(Images.goldenStar, width: 75.w))
            ],
          )
        ],
      ),
    );
  }
}
