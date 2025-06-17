import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/teachers/cubit/teachers_cubit.dart';
import 'package:my_project_new/modules/teachers/models/teacher.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_course_card.dart';
import 'package:my_project_new/utils/clipper.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/blue_circle.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/try_again.dart';

class TeacherDetailsScreen extends StatelessWidget {
  const TeacherDetailsScreen({super.key, required this.teacherId});
  final int teacherId;
  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(indent: 80.w, endIndent: 80.w, height: 40.h);
    return AppScaffold(
        appBarBorderRadius: BorderRadius.zero,
        title: translate("about_teacher", context),
        body: BlocProvider(
          create: (context) =>
              TeachersCubit()..getTeacherDetails(teacherId: teacherId),
          child: BlocBuilder<TeachersCubit, TeachersState>(
            builder: (context, state) {
              final TeachersCubit teachersCubit = context.read<TeachersCubit>();
              if (state is GetTeacherDetailsLoading) {
                return const AppLoading();
              }
              if (state is GetTeacherDetailsError) {
                return TryAgain(
                    onTap: () {
                      teachersCubit.getTeacherDetails(teacherId: teacherId);
                    },
                    message: state.message);
              }

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _Header(teacher: teachersCubit.teacherDetails),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TeacherDetails(
                              divider: divider,
                              teacher: teachersCubit.teacherDetails),
                          divider,
                          _CoursesLayer(
                            teacher: teachersCubit.teacherDetails,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class _CoursesLayer extends StatelessWidget {
  const _CoursesLayer({required this.teacher});
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate('courses', context),
          style: titilliumBold.copyWith(color: AppColors.PRIMARY),
        ),
        if (teacher.courses.isEmpty)
          const NoData(title: "لا يوجد كورسات حالياً ")
        else
          GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: teacher.courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return TeacherCourseCard(
                course: teacher.courses[index],
                footerColor: AppColors.appColors[index % 4],
              );
            },
          ),
      ],
    );
  }
}

class TeacherDetails extends StatelessWidget {
  const TeacherDetails({
    super.key,
    required this.divider,
    required this.teacher,
  });

  final Divider divider;
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      maxLength: 100,
      text: teacher.description,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.teacher});
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          ClipPath(
            clipper: TeacherClipper(),
            child: Container(
              padding: EdgeInsets.all(10.w),
              width: 1.sw,
              height: 270.h,
              decoration: const BoxDecoration(color: AppColors.SECONDRY),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      spacing: 5.h,
                      children: [
                        SizedBox(height: 20.h),
                        SizedBox(
                            child: Text(
                          teacher.username,
                          style: titilliumBold,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(
                          child: Text(teacher.job,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumBold.copyWith(
                                  color: AppColors.WHITE)),
                        ),
                        SizedBox(height: 10.h),
                        if (teacher.logo.isNotEmpty)
                          SizedBox(
                            width: 50.w,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CachedImage(image: teacher.logo),
                            ),
                          )
                      ],
                    ),
                  ),
                  const Spacer(flex: 4)
                ],
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            left: 10.w,
            child: Container(
                width: 160.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    boxShadow: boxShadow,
                    color: AppColors.WHITE,
                    shape: BoxShape.circle),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedImage(
                    image: teacher.image,
                    boxFit: BoxFit.cover,
                  ),
                )),
          ),
          Positioned(bottom: 23.h, left: -7, child: BlueCircle(diagram: 38.w)),
          Positioned(bottom: 0, left: -24, child: BlueCircle(diagram: 38.w))
        ],
      ),
    );
  }
}
