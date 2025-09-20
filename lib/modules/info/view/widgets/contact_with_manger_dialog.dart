import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/info/models/info_response.dart';
import 'package:salamat/modules/info/view/widgets/contact_row.dart';

class ContactWithMangerDialog extends StatelessWidget {
  const ContactWithMangerDialog({super.key, required this.platformManager});
  final PlatformManaGer platformManager;
  static void show(context, {required PlatformManaGer platformManager}) {
    showDialog(
      context: context,
      builder: (context) => ContactWithMangerDialog(
        platformManager: platformManager,
      ),
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
                flex: 3,
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
                        text: ""),
                    ContactRow(
                        icon: Icon(
                            size: 30.sp, Icons.facebook, color: Colors.blue),
                        text: ""),
                    ContactRow(
                        icon: Icon(
                            size: 30.sp,
                            Icons.telegram,
                            color: AppColors.PRIMARY),
                        text: ""),
                    ContactRow(
                        icon: SvgPicture.asset(
                          Images.youtube,
                          width: 30.sp,
                        ),
                        text: ""),
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
