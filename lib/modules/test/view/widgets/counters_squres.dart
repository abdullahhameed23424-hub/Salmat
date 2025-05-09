import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/view/widgets/test_info.dart';
import 'package:my_project_new/utils/sliver_delegate.dart';

class CountersSqures extends StatelessWidget {
  const CountersSqures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverDelegate(
          minHeight: 95.h,
          maxHeight: 105.h,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            color: AppColors.SECONDRY,
            child: Row(
              children: [
                Expanded(
                  child: TestInfo(
                    text: translate('points', context),
                    value: "120",
                  ),
                ),
                Expanded(
                  child: TestInfo(
                    text: translate('attempt_count', context),
                    value: "5",
                  ),
                ),
                Expanded(
                  child: TestInfo(
                    text: translate('timer', context),
                    value: "8:30",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
