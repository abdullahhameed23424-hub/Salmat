import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/library/cubit/library_cubit.dart';
import 'package:my_project_new/modules/library/models/library_section.dart';
import 'package:my_project_new/modules/library/view/widgets/book_card.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key, required this.librarySection});
  final LibrarySection librarySection;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: librarySection.name,
      body: BlocProvider(
        create: (context) => LibraryCubit()..getBooks(librarySection.id),
        child: BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, state) {
            final cubit = context.read<LibraryCubit>();
            if (state is LibraryLoadingState) {
              return const AppLoading();
            }
            if (state is LibraryErrorState) {
              return TryAgain(
                onTap: () => context.read<LibraryCubit>().getBooks(
                      librarySection.id,
                    ),
                message: state.message,
              );
            }

            if (cubit.libraryBooks.isEmpty) {
              return const NoData();
            }
            return Stack(
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
                SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: cubit.refreshController,
                  onRefresh: () {
                    cubit.page = 1;
                    cubit.getBooks(librarySection.id);
                  },
                  footer: const AppFooter(),
                  onLoading: () {
                    cubit.getBooks(librarySection.id);
                  },
                  header: const AppRefresherHeader(),
                  child: CustomScrollView(
                    slivers: [
                      // const SliverToBoxAdapter(child: _TopBanner()),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 26.h),
                        sliver: SliverGrid.builder(
                            itemCount: cubit.libraryBooks.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 30.h,
                            ),
                            itemBuilder: (context, index) => BookCard(
                                  primaryColor: AppColors.appColors[index % 4],
                                  book: cubit.libraryBooks[index],
                                )),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
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
