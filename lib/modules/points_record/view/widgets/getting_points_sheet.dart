import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/dimensions.dart';

class GettingPointsSheet extends StatelessWidget {
  final String content;

  const GettingPointsSheet({
    super.key,
    required this.content,
  });

  static void show(BuildContext context, String content) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => GettingPointsSheet(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: SizedBox(
          height: 0.6.sh,
          child: Column(
            children: <Widget>[
              SizedBox(width: 1.sw),
              Container(
                  margin: EdgeInsets.all(16.w),
                  color: AppColors.GRAY600,
                  width: 50.w,
                  height: 2),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      content,
                      style: titilliumRegular.copyWith(
                        fontSize: 16.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
