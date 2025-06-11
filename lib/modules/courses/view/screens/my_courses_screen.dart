import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/courses/cubit/courses_cubit.dart';
import 'package:my_project_new/modules/courses/view/widgets/my_course_card.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: translate('my_courses', context),
      body: BlocProvider(
        create: (context) => CoursesCubit()..getMycourses(),
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            final CoursesCubit coursesCubit = context.read<CoursesCubit>();
            if (state is GetCoursesLoadingState) {
              return const AppLoading();
            }

            if (state is GetCoursesErrorState) {
              return TryAgain(
                  onTap: () {
                    coursesCubit.getMycourses();
                  },
                  message: state.message);
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: <Widget>[
                    _CoursesHeader(numOfCourses: coursesCubit.courses.length),
                    SizedBox(height: 40.h),
                    Expanded(
                      child: coursesCubit.courses.isNotEmpty
                          ? SmartRefresher(
                              header: const AppRefresherHeader(),
                              footer: const AppFooter(),
                              enablePullUp: true,
                              controller: coursesCubit.refreshController,
                              onLoading: () {
                                coursesCubit.getMycourses();
                              },
                              onRefresh: () {
                                coursesCubit.refreshController.loadComplete();
                                coursesCubit.page = 1;
                                coursesCubit.getMycourses();
                              },
                              child: GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.9,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.w,
                                    mainAxisSpacing: 15.h,
                                  ),
                                  itemCount:
                                      coursesCubit.courses.length, // عدد المواد
                                  itemBuilder: (context, index) => MyCourseCard(
                                      course: coursesCubit.courses[index])))
                          : const NoData(),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: 40.h,
                  end: 20.w,
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                        boxShadow: boxShadow,
                        color: AppColors.WHITE,
                        shape: BoxShape.circle),
                    child: Image.asset(Images.books),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CoursesHeader extends StatelessWidget {
  const _CoursesHeader({required this.numOfCourses});
  final int numOfCourses;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.SECONDRY),
      height: 80.h,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: <Widget>[
          Text(
            "${translate('my_courses', context)} $numOfCourses",
            style: titilliumSemiBold,
          ),
          const Spacer(),
          Container(width: 70.w),
        ],
      ),
    );
  }
}
