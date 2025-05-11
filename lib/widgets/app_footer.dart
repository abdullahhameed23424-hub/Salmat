import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (context, mode) {
      return Center(
        child: FadeIn(
          child: Builder(
            builder: (context) {
              if (mode == LoadStatus.noMore) {
                return Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Text(
                    translate('no_more_data', context),
                    style: titilliumSemiBold,
                  ),
                );
              }

              if (mode == LoadStatus.idle || mode == LoadStatus.canLoading) {
                return Text(translate('pull_up_to_load_more', context),
                    style: titilliumSemiBold);
              }

              if (mode == LoadStatus.loading) {
                return const AppLoading();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  }
}
