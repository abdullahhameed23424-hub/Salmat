import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/sections/models/section.dart';
import 'package:my_project_new/modules/subjects/cubit/subjects_cubit.dart';
import 'package:my_project_new/modules/subjects/view/widgets/subject_card.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key, required this.section});

  final Section section;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.LIGHTGRAY,
      title: section.name,
      body: BlocProvider(
        create: (context) =>
            SubjectsCubit()..getSubjects(sectionId: section.id),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: BlocBuilder<SubjectsCubit, SubjectsState>(
            builder: (context, state) {
              final SubjectsCubit subjectsCubit = context.read<SubjectsCubit>();
              if (state is GetSubjectsLoadingState) {
                return const AppLoading();
              }
              if (state is GetSubjectsErrorState) {
                return TryAgain(
                    onTap: () {
                      subjectsCubit.getSubjects(sectionId: section.id);
                    },
                    message: state.message);
              }
              return SmartRefresher(
                header: AppRefresherHeader(),
                footer: const AppFooter(),
                enablePullUp: true,
                controller: subjectsCubit.refreshController,
                onLoading: () {
                  subjectsCubit.getSubjects(sectionId: section.id);
                },
                onRefresh: () {
                  subjectsCubit.refreshController.loadComplete();
                  subjectsCubit.page = 1;
                  subjectsCubit.getSubjects(sectionId: section.id);
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          Image.asset(Images.subjectHint, width: 1.sw),
                          Divider(endIndent: 70.w, indent: 70.w, height: 48.h)
                        ],
                      ),
                    ),
                    SliverGrid.builder(
                      itemCount: subjectsCubit.subjects.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 30.h, crossAxisCount: 2),
                      itemBuilder: (context, index) => SubjectCard(
                          subject: subjectsCubit.subjects[index],
                          primaryColor: AppColors.appColors[index % 4]),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
