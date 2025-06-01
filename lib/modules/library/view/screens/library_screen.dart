import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/library/cubit/library_cubit.dart';
import 'package:my_project_new/modules/library/view/widgets/library_section_card.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('library', context),
      body: BlocProvider(
        create: (context) => LibraryCubit()..getLibrarySections(),
        child: BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, state) {
            final cubit = context.read<LibraryCubit>();
            if (state is LibraryLoadingState) {
              return const AppLoading();
            }
            if (state is LibraryErrorState) {
              return TryAgain(
                onTap: () => cubit.getLibrarySections(),
                message: state.message,
              );
            }
            if (cubit.librarySections.isEmpty) {
              return const NoData();
            }
            return SmartRefresher(
              controller: cubit.refreshController,
              // enablePullDown: true,

              footer: const AppFooter(),
              header: const AppRefresherHeader(),
              enablePullUp: true,
              onRefresh: () {
                cubit.refreshController.loadComplete();
                cubit.page = 1;
                cubit.getLibrarySections();
              },
              onLoading: () {
                cubit.getLibrarySections();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 1.sw,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CachedImage(
                              borderRadius: BorderRadius.circular(10),
                              image: cubit.image,
                              boxFit: BoxFit.cover,
                              width: 1.sw,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        ReadMoreText(text: cubit.description, maxLength: 100),
                        SizedBox(height: 15.h)
                      ],
                    ),
                  )),
                  SliverGrid.builder(
                    itemCount: cubit.librarySections.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .9,
                        mainAxisSpacing: 20.h),
                    itemBuilder: (context, index) {
                      return LibrarySectionCard(
                          librarySection: cubit.librarySections[index],
                          footerColor: AppColors.appColors[index % 4]);
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
