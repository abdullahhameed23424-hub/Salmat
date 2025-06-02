import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/courses/models/unit.dart';
import 'package:my_project_new/modules/lessons/cubit/lessons_cubit.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/lessons/view/screens/lesson_details_screen.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_card.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/try_again.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key, required this.unit});
  static bool refrshLessonsScreen = false;

  final Unit unit;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: unit.name,
        body: BlocProvider(
          create: (context) => LessonsCubit()..getLessons(unitId: unit.id),
          child: BlocBuilder<LessonsCubit, LessonsState>(
            builder: (context, state) {
              final LessonsCubit lessonsCubit = context.read<LessonsCubit>();
              if (state is GetLessonsLoadingState) {
                return const AppLoading();
              }
              if (state is GetLessonsErrorState) {
                return TryAgain(
                    onTap: () {
                      lessonsCubit.getLessons(unitId: unit.id);
                    },
                    message: state.message);
              }
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          child: Text(
                            unit.description,
                            style: titilliumBold,
                          ),
                        ),
                        Divider(indent: 75.w, endIndent: 75.w),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        final Lesson lesson = lessonsCubit.lessons[index];
                        return LessonCard(
                            onTap: lesson.isOpen
                                ? () async {
                                    LessonsScreen.refrshLessonsScreen = false;
                                    final Map<String, dynamic>? params =
                                        await pushTo(
                                            context: context,
                                            toPage: LessonDetailsScreen(
                                                lesson: lesson));
                                    if (params != null &&
                                        params['next_unit_id'] != null) {
                                      lessonsCubit.getLessons(
                                          unitId: params['next_unit_id']);
                                    } else if (LessonsScreen
                                        .refrshLessonsScreen) {
                                      lessonsCubit.getLessons(unitId: unit.id);
                                    }
                                  }
                                : null,
                            lesson: lessonsCubit.lessons[index],
                            index: index);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15.h),
                      itemCount: lessonsCubit.lessons.length,
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
