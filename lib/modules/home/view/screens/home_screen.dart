import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field_to_push.dart';
import 'package:my_project_new/modules/home/cubit/home_cubit.dart';
import 'package:my_project_new/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:my_project_new/modules/home/view/widgets/home_section_card.dart';
import 'package:my_project_new/modules/library/view/screens/library_screen.dart';
import 'package:my_project_new/modules/offers/view/widgets/offer_card.dart';
import 'package:my_project_new/modules/sections/models/section.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/view/screens/comments_screen.dart';
import 'package:my_project_new/modules/offers/models/offer.dart';
import 'package:my_project_new/modules/offers/view/screens/offers_screen.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/delete_dialog.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/swaping_point.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeInfo(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit homeCubit = context.read<HomeCubit>();
          if (state is GetHomeLoadingState) {
            return const AppLoading();
          }
          if (state is GetHomeErrorState) {
            return TryAgain(
              onTap: () {
                homeCubit.getHomeInfo();
              },
              message: state.message,
            );
          }

          return SmartRefresher(
            header: AppRefresherHeader(),
            controller: homeCubit.refreshController,
            onRefresh: () {
              homeCubit.getHomeInfo();
            },
            child: CustomScrollView(
              slivers: [
                _OffersLayer(offers: homeCubit.offers),
                SliverToBoxAdapter(
                  child: _ViewAll(
                      onTap: () {
                        selectedPage.value = 0;
                      },
                      title: translate("sections", context)),
                ),
                _SectionsLayer(sections: homeCubit.sections),
                _LibraryLayer(libraryImage: homeCubit.libraryImage),
                SliverToBoxAdapter(
                  child: _ViewAll(
                      onTap: () {
                        final CommentsCubit commentsCubit = CommentsCubit();
                        pushTo(
                            context: context,
                            toPage: CommentsScreen(
                                commentsCubit: commentsCubit,
                                getComments: () {
                                  commentsCubit.getComments();
                                }));
                      },
                      title: translate("comments", context)),
                ),
                _ReviewLayer(comments: homeCubit.platformComments),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Image.asset(Images.homeCompanyLogo, width: 1.sw),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 100.h))
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ReviewLayer extends StatefulWidget {
  final List<Comment> comments;
  _ReviewLayer({required this.comments});

  @override
  State<_ReviewLayer> createState() => _ReviewLayerState();
}

class _ReviewLayerState extends State<_ReviewLayer> {
  final CommentsCubit commentsCubit = CommentsCubit();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.h,
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            ...List.generate(
              widget.comments.take(3).length,
              (index) => CommentCard(
                  commentsCubit: commentsCubit,
                  onDelete: () {
                    DeleteDialog.show(context,
                        title: translate("delete_comment", context),
                        content: translate("delete_comment_content", context),
                        onConfirm: () async {
                      await commentsCubit.deleteComment(
                          commentId: widget.comments[index].id);

                      if (commentsCubit.state is DeleteCommentsSuccessState) {
                        widget.comments.removeAt(index);
                        setState(() {});  
                      }
                    });
                  },
                  comment: widget.comments[index]),
            ),
            CommentInputFieldToPush(
              commentsCubit: commentsCubit,
              getComments: () {
                commentsCubit.getComments();
              },
            )
          ],
        ),
      ),
    );
  }
}

class _LibraryLayer extends StatelessWidget {
  final String libraryImage;
  const _LibraryLayer({required this.libraryImage});
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
          children: <Widget>[
            SizedBox(
              width: 1.sw - 155.w - 28.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(translate("platform_library", context),
                        style: titilliumBold, textAlign: TextAlign.center),
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
            SizedBox(
              width: 150.w,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedImage(
                  image: libraryImage,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionsLayer extends StatelessWidget {
  final List<Section> sections;
  const _SectionsLayer({required this.sections});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        height: 204.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => HomeSectionCard(
            section: sections[index],
          ),
          itemCount: sections.length,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: <Widget>[
          Text(title, style: titilliumBold),
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
    );
  }
}

class _OffersLayer extends StatefulWidget {
  final List<Offer> offers;
  const _OffersLayer({required this.offers});

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
          _ViewAll(
              onTap: () {
                pushTo(context: context, toPage: const OffersScreen());
              },
              title: translate("offers", context)),
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
                widget.offers.length,
                (index) {
                  return OfferCard(offer: widget.offers[index]);
                },
              )),
          SizedBox(height: 3.h),
          SwappingPoints(
              length: widget.offers.length,
              pageController: controller,
              currentIndex: _currentindex),
        ],
      ),
    );
  }
}
