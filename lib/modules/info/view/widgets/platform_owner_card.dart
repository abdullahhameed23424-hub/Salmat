import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/info/models/info_response.dart';
import 'package:my_project_new/modules/info/view/widgets/contact_with_manger_dialog.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class PlatformManagerCard extends StatelessWidget {
  const PlatformManagerCard({
    super.key,
    required this.platformManager,
  });
  final PlatformManaGer platformManager;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ContactWithMangerDialog.show(context, platformManager: platformManager);
      },
      child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 25.h),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            spacing: 15.w,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 100.w,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(10)),
                      child: CachedImage(
                        image: platformManager.image,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                spacing: 5,
                children: <Widget>[
                  Text(
                    platformManager.name,
                    style: titilliumBold.copyWith(
                        color: AppColors.PRIMARY,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.PRIMARY),
                  ),
                  Text(platformManager.description,
                      maxLines: 2,
                      style: titilliumRegular.copyWith(fontSize: 12.sp),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: AppColors.LIGHTGRAY,
                          borderRadius: BorderRadius.circular(20)),
                      transform: Matrix4.translationValues(
                          Localizations.localeOf(context).languageCode == "ar"
                              ? 10.w
                              : -10,
                          20.h,
                          0),
                      child: CustomButton(
                        size: Size(140.w, 40.h),
                        padding: EdgeInsets.all(6.w),
                        buttonStyle: titilliumBold.copyWith(
                            fontSize: 14.sp, color: AppColors.WHITE),
                        label: translate('messaging', context),
                        onPressed: () {
                          ContactWithMangerDialog.show(context,
                              platformManager: platformManager);
                        },
                      ),
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }
}
