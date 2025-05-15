import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/home/cubit/home_cubit.dart';
import 'package:my_project_new/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:my_project_new/modules/home/view/widgets/home_section_card.dart';
import 'package:my_project_new/modules/library/view/screens/library_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/view/screens/comments_screen.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field.dart';
import 'package:my_project_new/modules/offers/view/screens/offers_screen.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/swaping_point.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit homeCubit = context.read<HomeCubit>();
          if (state is GetHomeLoadingState) {
            return AppLoading();
          }
          return CustomScrollView(
            slivers: [
              _ViewAll(
                  onTap: () {
                    pushTo(context: context, toPage: const OffersScreen());
                  },
                  title: translate("offers", context)),
              const _OffersLayer(),
              _ViewAll(
                  onTap: () {
                    selectedPage.value =
                        0; // bottomNavScreen.currentState?.changeScreen(0);
                  },
                  title: translate("sections", context)),
              _SectionsLayer(),
              _LibraryLayer(),
              _ViewAll(
                  onTap: () =>
                      pushTo(context: context, toPage: CommentsScreen()),
                  title: translate("comments", context)),
              const _ReviewLayer(),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Image.asset(
                    Images.homeCompanyLogo,
                    width: 1.sw,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100.h))
            ],
          );
        },
      ),
    );
  }
}

class _ReviewLayer extends StatelessWidget {
  const _ReviewLayer();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 16.w,
        ),
        child: Column(
          children: [
        
            CommentInputField(
              forPushToCommentsScreen: true,
              commentsCubit: CommentsCubit(),
            )
          ],
        ),
      ),
    );
  }
}

class _LibraryLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
        height: 180.h,
        decoration: BoxDecoration(
            color: AppColors.LIGHTGRAY,
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 1.sw - 155.w - 28.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      translate("platform_library", context),
                      style: titilliumBold,
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      borderRadius: BorderRadius.circular(10),
                      label: translate("go", context),
                      onPressed: () {
                        pushTo(context: context, toPage: const LibraryScreen());
                      },
                      size: Size(55.w, 30.h),
                    )
                  ],
                ),
              ),
            ),
            Image.asset(
              Images.library,
              width: 130.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionsLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        height: 204.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => HomeSectionCard(
            index: index,
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}

class _ViewAll extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const _ViewAll({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: titilliumBold,
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  onTap();
                },
                child: Row(
                  children: [
                    Text(
                      translate("view_all", context),
                      style: titilliumBold.copyWith(
                        color: AppColors.PURPLE_LIGHT,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.PURPLE_LIGHT,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20.sp,
                      color: AppColors.PURPLE_LIGHT,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class _OffersLayer extends StatefulWidget {
  const _OffersLayer();

  // final InfoCubit infoCubit;

  @override
  State<_OffersLayer> createState() => _OffersLayerState();
}

class _OffersLayerState extends State<_OffersLayer> {
  int _currentindex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                viewportFraction: 0.98,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentindex = index;
                  });
                },
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              items: List.generate(
                5, // widget.infoCubit.whoUsImage.length,
                (index) => Container(
                    margin: const EdgeInsets.all(1),
                    width: 1.sw,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.asset(
                      index.isEven ? Images.homeOffer : Images.offer,
                      fit: BoxFit.fill,
                    )
                    //  CachedImage(image: widget.infoCubit.whoUsImage[index]),
                    ),
              )),
          SizedBox(height: 3.h),
          SwappingPoint(
              length: 5,
              pageController: controller,
              currentIndex: _currentindex),
        ],
      ),
    );
  }
}
