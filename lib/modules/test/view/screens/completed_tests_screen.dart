import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/view/widgets/completed_test_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class CompletedTestsScreen extends StatelessWidget {
  const CompletedTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      title: translate('completed_tests', context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Image.asset(Images.completedTests),
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              child: Text(
                translate('completed_tests', context),
                style: titilliumBold.copyWith(
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            sliver: SliverGrid.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 25.h,
              ),
              itemBuilder: (context, index) => const CompletedTestCard(),
            ),
          )
        ],
      ),
    );
  }
}
