import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/courses/models/course.dart';
import 'package:my_project_new/modules/courses/view/screens/course_details_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/cached_image.dart';

class TeacherCourseCard extends StatelessWidget {
  final Course course;
  final Color footerColor;
  const TeacherCourseCard({
    super.key,
    required this.course,
    required this.footerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: CourseDetailsScreen(course: course));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedImage(
                  image: course.image,
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: footerColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  course.name,
                  style: titilliumBold.copyWith(color: AppColors.WHITE),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
