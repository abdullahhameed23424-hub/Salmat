import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/teachers/models/teacher.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('teachers', context),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: 32.h,
            horizontal: 16.w,
          ),
          separatorBuilder: (context, index) => const Divider(height: 50),
          itemBuilder: (context, index) => TeacherCard(
                teacher: Teacher.fromJson({}),
              ),
          itemCount: 10),
    );
  }
}
