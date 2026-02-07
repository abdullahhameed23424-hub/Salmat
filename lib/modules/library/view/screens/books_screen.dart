import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/library/cubit/library_cubit.dart';
import 'package:salamat/modules/library/models/library_section.dart';
import 'package:salamat/modules/library/view/widgets/book_card.dart';
import 'package:salamat/widgets/app_footer.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/no_data.dart';
import 'package:salamat/widgets/refresher_header.dart';
import 'package:salamat/widgets/try_again.dart';
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
            final hasCachedBooks = cubit.libraryBooks.isNotEmpty;
            final isOfflineFallback =
                state is LibraryErrorState && hasCachedBooks;

            if (state is LibraryLoadingState && !hasCachedBooks) {
              return const AppLoading();
            }
            if (state is LibraryErrorState && !hasCachedBooks) {
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
                if (isOfflineFallback)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _OfflineNotice(),
                  ),
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

class _OfflineNotice extends StatelessWidget {
  const _OfflineNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.PRIMARY,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.PRIMARY.withOpacity(.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, color: Colors.white, size: 18),
          SizedBox(width: 8.w),
          Text(
            'المكتبة تعمل دون إنترنت',
            style: titilliumSemiBold.copyWith(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
