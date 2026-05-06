import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/widgets/platform_feature_card.dart';
import 'package:salamat/modules/info/view/widgets/platform_owner_card.dart';
import 'package:salamat/widgets/custom_button.dart';

class RestOfInfo extends StatelessWidget {
  final InfoCubit infoCubit;

  const RestOfInfo({super.key, required this.infoCubit});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15.h),

          /// [ABOUT_US_TITLE_WITH_DESCRIPTION]
          /// عنوان و وصف التطبيق
          Text(
            translate('about_us', context),
            style: titilliumBold.copyWith(color: AppColors.PRIMARY),
          ),
          Divider(
            height: 25.h,
            endIndent: 190.w,
          ),
          Text(
            infoCubit.infoResponse.aboutUs.description,
            style: titilliumRegular,
          ),
          SizedBox(height: 30.h),

          /// [APP_FEATURES_TITLE]
          /// عنوان مميزات التطبيق
          Text(
            translate('app_features', context),
            style: titilliumBold.copyWith(color: AppColors.PRIMARY),
          ),
          SizedBox(height: 20.h),

          /// [APP_FEATURES_LIST]
          /// قائمة مميزات التطبيق
          GridView.builder(
            itemCount: infoCubit.infoResponse.features.texts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              crossAxisCount: 2,
              mainAxisSpacing: 25.h,
            ),
            itemBuilder: (context, index) => PlatformFeatureCard(
              image: index < 4 ? Images.numbers[index] : null,
              number: (index + 1).toString(),
              text: infoCubit.infoResponse.features.texts[index],
            ),
          ),
          SizedBox(height: 20.h),

          /// [PLATFORM_MANAGER_TITLE_WITH_DESCRIPTION]
          /// عنوان و وصف ادارة المنصة
          if (infoCubit.infoResponse.platformManager.show)
            Text(
              translate('platform_manager', context),
              style: titilliumBold.copyWith(color: AppColors.PRIMARY),
            ),
          if (infoCubit.infoResponse.platformManager.show)
            SizedBox(height: 20.h),

          /// [PLATFORM_MANAGER_CARD]
          /// بطاقة ادارة المنصة
          if (infoCubit.infoResponse.platformManager.show)
            PlatformManagerCard(
              platformManager: infoCubit.infoResponse.platformManager,
            ),
          SizedBox(height: 40.h),

          /// [SHARE_APP_BUTTON]
          /// زر مشاركة التطبيق
          CustomButton(
            label: translate('share_app', context),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.r),
              bottomLeft: Radius.circular(25.r),
            ),
            onPressed: () {
              // Share.share(infoCubit.infoResponse. );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
