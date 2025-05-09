import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "الأشعة 1",
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      'عزيزي الطالب تجد في الأسفل جميع دروس الوحدة الأولى',
                      style: titilliumBold,
                    ),
                  ),
                  Divider(indent: 75.w, endIndent: 75.w),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: SliverList.separated(
                itemBuilder: (context, index) => const LessonCard(),
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemCount: 10,
              ),
            )
          ],
        ));
  }
}
