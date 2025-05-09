import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';  

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: <Widget>[
                Image.asset(width: 72.w, Images.examScreenHeader),
                SizedBox(
                  width: 1.sw - 72.w - 48.w,
                  child: Text(
                    'اجعل من هذا الاختبار تحديًا ممتعًا! استمتع بالرحلة ولا تنظر إلى النهاية ..',
                    style: titilliumSemiBold.copyWith(fontSize: 14.sp),
                  ),
                )
              ],
            )));
  }
}
