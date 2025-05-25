import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/notifications/models/notification.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/widgets/read_more_text.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.WHITE,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.LIGHTGRAY,
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            isThreeLine: true,
            contentPadding: const EdgeInsets.all(8),
            leading: ZoomIn(
                delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
                child: Image.asset(Images.notification, width: 50.w)),
            subtitle: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(notification.createdAt,
                            style: titilliumBold.copyWith(fontSize: 12.sp)),
                      ),
                      const Spacer(),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Image.asset(
                          color: notification.hasRead ? Colors.green : null,
                          Images.checkMark,
                          width: 22.w,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    endIndent: 140.w,
                  ),
                  ReadMoreText(
                    text: notification.title,
                    maxLength: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
