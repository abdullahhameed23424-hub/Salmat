import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/info/view/screens/about_us_screen.dart';
import 'package:my_project_new/modules/info/view/widgets/contact_row.dart';

class ContactWithMangerDialog extends StatelessWidget {
  const ContactWithMangerDialog({super.key});

  static void show(context) {
    showDialog(
      context: context,
      builder: (context) => const ContactWithMangerDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'يمكنك التواصل مع المدير عبر:',
                      style: titleHeader.copyWith(
                          color: AppColors.PRIMARY, fontSize: 18.sp),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 12.h),
                    ContactRow(
                        icon: SvgPicture.asset(
                          Images.whatsapp,
                          width: 28.sp,
                        ),
                        text: '098877441155'),
                    ContactRow(
                        icon: Icon(
                            size: 30.sp, Icons.facebook, color: Colors.blue),
                        text: 'Facebook.com'),
                    ContactRow(
                        icon: Icon(
                            size: 30.sp,
                            Icons.telegram,
                            color: AppColors.PRIMARY),
                        text: '@Salamat_20'),
                    ContactRow(
                        icon: SvgPicture.asset(
                          Images.youtube,
                          width: 30.sp,
                        ),
                        text: 'Youtube.com'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  Images.contactImage, // Replace with your asset
                  height: 170.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
