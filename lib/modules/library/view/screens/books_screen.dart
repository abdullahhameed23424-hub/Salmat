import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/library/view/widgets/book_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "الثالث الثانوي",
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 140.w,
                height: 150.h,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: AppColors.PRIMARY,
                      blurRadius: 100.0,
                      spreadRadius: 0.0,
                      offset: Offset(-10, -10))
                ]),
              )),
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _TopBanner()),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 26.h),
                sliver: SliverGrid.builder(
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30.h,
                    ),
                    itemBuilder: (context, index) => BookCard(
                          primaryColor: AppColors.appColors[index % 4],
                        )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  const _TopBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(Images.whiteBanner, width: 140.w),
        Positioned(
          bottom: 30.h,
          child: Column(
            children: <Widget>[
              Text(
                "9",
                style: titilliumBold.copyWith(
                    fontSize: 28.sp,
                    fontFamily: "nosifer",
                    color: AppColors.PRIMARY),
              )
            ],
          ),
        )
      ],
    );
  }
}
