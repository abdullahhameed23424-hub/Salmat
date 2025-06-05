import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/sections/cubit/sections_cubit.dart';
import 'package:my_project_new/modules/sections/view/widgets/section_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SectionsCubit()..getSections(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<SectionsCubit, SectionsState>(
          builder: (context, state) {
            final SectionsCubit sectionsCubit = context.read<SectionsCubit>();

            if (state is GetSectionsLoadingState) {
              return const AppLoading();
            }
            if (state is GetSectionsErrorState) {
              return TryAgain(
                  onTap: () {
                    sectionsCubit.getSections();
                  },
                  message: state.message);
            }

            return SmartRefresher(
              enablePullUp: state is! GetSectionsLoadingState,
              enablePullDown: state is! GetSectionsLoadingState,
              controller: sectionsCubit.refreshController,
              footer: CustomFooter(builder: (context, mode) {
                return const SizedBox.shrink();
              }),
              onLoading: () {
                sectionsCubit.getSections();
              },
              onRefresh: () {
                sectionsCubit.refreshController.loadComplete();
                sectionsCubit.page = 1;
                sectionsCubit.getSections();
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      sliver: SliverToBoxAdapter(
                        child: Text(sectionsCubit.headerText,
                            style: titilliumSemiBold),
                      )),
                  SliverList.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) => SectionCard(
                          section: sectionsCubit.sections[index],
                          index:
                              index), // index for a color if odd add another color for even
                      itemCount: sectionsCubit.sections.length),
                  SliverToBoxAdapter(
                      child: PaginitionFotter(
                          refreshController: sectionsCubit.refreshController)),
                  SliverToBoxAdapter(child: SizedBox(height: 120.h))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaginitionFotter extends StatefulWidget {
  const PaginitionFotter({super.key, required this.refreshController});

  final RefreshController refreshController;

  @override
  PaginitionFotterState createState() => PaginitionFotterState();
}

class PaginitionFotterState extends State<PaginitionFotter> {
  @override
  void initState() {
    widget.refreshController.footerMode!.addListener(
      () {
        widget.refreshController.footerStatus;
        if (mounted) setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeIn(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Builder(
            builder: (context) {
              if (widget.refreshController.footerStatus == LoadStatus.noMore) {
                return Text(
                  translate('no_more_data', context),
                  style: titilliumSemiBold,
                );
              }

              if (widget.refreshController.footerStatus == LoadStatus.idle) {
                return Text(translate('pull_up_to_load_more', context),
                    style: titilliumSemiBold);
              }

              if (widget.refreshController.footerStatus == LoadStatus.loading) {
                return const AppLoading();
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
