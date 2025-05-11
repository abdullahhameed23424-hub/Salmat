// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/courses/cubit/courses_cubit.dart';
import 'package:my_project_new/modules/courses/view/widgets/course_card.dart';
import 'package:my_project_new/modules/subjects/models/subject.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/blue_circle.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key, required this.subject});
  final Subject subject;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: subject.name,
      body: Stack(
        children: [
          Positioned(
              bottom: -23.h, left: -18.w, child: BlueCircle(diagram: 120.w)),
          Positioned(
              bottom: 66.h, left: 102.w, child: BlueCircle(diagram: 55.w)),
          Positioned(
              bottom: -59.h, right: -32.w, child: BlueCircle(diagram: 160.w)),
          BlocProvider(
            create: (context) =>
                CoursesCubit()..getCourses(subjectId: subject.id),
            child: BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                final CoursesCubit coursesCubit = context.read<CoursesCubit>();

                if (state is GetCoursesLoadingState) {
                  return const AppLoading();
                }
                if (state is GetCoursesErrorState) {
                  return TryAgain(
                      onTap: () {
                        coursesCubit.getCourses(subjectId: subject.id);
                      },
                      message: state.message);
                }

                if (coursesCubit.courses.isEmpty) {
                  return SizedBox(height: 1.sh, child: const Nodata());
                }
                return SmartRefresher(
                  header: AppRefresherHeader(),
                  footer: const AppFooter(),
                  enablePullUp: true,
                  controller: coursesCubit.refreshController,
                  onLoading: () {
                    coursesCubit.getCourses(subjectId: subject.id);
                  },
                  onRefresh: () {
                    coursesCubit.refreshController.loadComplete();
                    coursesCubit.page = 1;
                    coursesCubit.getCourses(subjectId: subject.id);
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) => CourseCard(
                            course: coursesCubit.courses[index],
                            primaryColor: AppColors.appColors[index % 4],
                          ),
                      separatorBuilder: (context, index) =>
                          Divider(height: 5.h, indent: 65.w, endIndent: 65.w),
                      itemCount: coursesCubit.courses.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
