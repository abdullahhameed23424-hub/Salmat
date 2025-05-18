import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/lessons/models/app_file.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    required this.file,
  });
   
  final AppFile file;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 400),
      delay: Duration(milliseconds: 100 * (1 + Random().nextInt(5))),
      child: InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(15),
            boxShadow: boxShadow,
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: 1.sw,
                  child: Image.asset(file.image, fit: BoxFit.contain),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.LIGHTGRAY,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),  
                  child: Center(
                    child: Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titilliumRegular.copyWith(color: AppColors.BLACK),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
