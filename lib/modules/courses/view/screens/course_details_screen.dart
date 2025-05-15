import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/dimensions.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field.dart';
import 'package:my_project_new/modules/courses/cubit/courses_cubit.dart';
import 'package:my_project_new/modules/courses/models/course.dart';
import 'package:my_project_new/modules/courses/models/unit.dart';
import 'package:my_project_new/modules/courses/view/widgets/unit_card.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/contact_with_admin_dialog.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/try_again.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.course});
  final Course course;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: course.name,
      body: BlocProvider(
        create: (context) =>
            CoursesCubit()..getCourseDetails(courseId: course.id),
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            final CoursesCubit coursesCubit =
                BlocProvider.of<CoursesCubit>(context);
            if (state is GetCourseDetailsLoadingState) {
              return const AppLoading();
            }
            if (state is GetCourseDetailsErrorState) {
              return TryAgain(
                  onTap: () {
                    coursesCubit.getCourseDetails(courseId: course.id);
                  },
                  message: state.message);
            }

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              children: [
                _CourseHeader(coursesCubit.couresDetails),
                _InfoCircles(coursesCubit.couresDetails, coursesCubit.units),
                SizedBox(height: 20.h),
                _CourseDetails(course: coursesCubit.couresDetails),
                SizedBox(height: 30.h),
                _Units(coursesCubit.units),
                SizedBox(height: 30.h),
                const _ReviewSection()
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translate("total_comments", context, args: ["12"]),
            style: titilliumSemiBold.copyWith(color: AppColors.DARK_GRAY)),
        SizedBox(height: 20.h),
        // const CommentCard( comment: ,),
          CommentInputField(forPushToCommentsScreen: true,commentsCubit: CommentsCubit(),),
      ],
    );
  }
}

class _Units extends StatelessWidget {
  const _Units(this.units);
  final List<Unit> units;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: AppColors.PURPLE_LIGHT,

      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      textColor: Colors.black, // ← هذا اللي يضبط اللون عند الفتح
      iconColor: Colors.black, // ← لتوحيد لون الأيقونة المفتوحة
      shape: const RoundedRectangleBorder(),
      tilePadding: EdgeInsets.symmetric(horizontal: 14.w),

      childrenPadding: EdgeInsets.zero,
      title: Text(
        translate('units', context),
        style: TextStyle(
          fontFamily: FONTF_FAMILY,
          // color: Colors.black, // we dont use titilliumBold to use pernt color
          fontSize: Dimensions.FONT_SIZE_DEFAULT,
          fontWeight: FontWeight.w700,
        ),
      ),
      children: List.generate(
        units.length,
        (index) => UnitCard(unit: units[index]),
      ),
    );
  }
}

class _CourseDetails extends StatelessWidget {
  final Course course;
  const _CourseDetails({required this.course});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoColumn(title: translate('description', context), children: [
          ReadMoreText(
            maxLength: 110,
            text: course.description,
          ),
        ]),
        _InfoColumn(
          title: translate('requirements', context),
          children: const [
            ReadMoreText(
                maxLength: 110,
                text: "كي تستطيع حضور المادة يجب الاشتراك بها أولا .."),
          ],
        ),
        _InfoColumn(title: translate('teacher', context), children: [
          ...List.generate(
            course.teachers.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              child: TeacherCard(teacher: course.teachers[index]),
            ),
          )
        ])
      ],
    );
  }
}

class _InfoCircles extends StatelessWidget {
  const _InfoCircles(this.course, this.units);
  final Course course;
  final List<Unit> units;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _InfoCircle(
          image: Images.unitsCircle,
          title: translate('units', context),
          value: units.length.toString(),
        ),
      ),
      Expanded(
        child: _InfoCircle(
          image: Images.lessonsCircle,
          title: translate("lessons", context),
          value: course.lessonsCount.toString(),
        ),
      ),
      Expanded(
        child: _InfoCircle(
          image: Images.hoursCircle,
          title: translate("hours", context),
          value: "${course.totalLessonsTime}h",
        ),
      ),
    ]);
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader(this.course);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 0.78.sw,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedImage(
                    borderRadius: BorderRadius.circular(12),
                    image: course.image,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        course.description,
                        style: titilliumSemiBold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            "${course.totalPrice} SP",
                            style: titilliumBold.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp,
                                color: AppColors.PRIMARY)),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => ContactWithAdminDialog(),
                            );
                          },
                          // style: IconButton.styleFrom(padding: const EdgeInsets.all(5)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(Images.buyIcon,
                                  width: 80.w,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.PRIMARY, BlendMode.srcIn)),
                              Positioned(
                                top: 25.h,
                                child: Text(
                                  translate('buy', context),
                                  style: titilliumBold.copyWith(
                                      color: AppColors.WHITE),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _InfoColumn({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26, width: 1))),
      child: ExpansionTile(
        shape: const BeveledRectangleBorder(),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: titilliumBold.copyWith(color: AppColors.PRIMARY),
        ),
        children: children,
      ),
    );
  }
}

class _InfoCircle extends StatelessWidget {
  const _InfoCircle(
      {required this.title, required this.value, required this.image});
  final String image;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(title, style: titilliumBold),
      SizedBox(height: 15.h),
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(image, width: 70.w),
          Text(
            value,
            style:
                titilliumRegular.copyWith(fontFamily: "bagel", fontSize: 20.sp),
          )
        ],
      )
    ]);
  }
}
