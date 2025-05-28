import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/teachers/cubit/teachers_cubit.dart';
import 'package:my_project_new/modules/teachers/models/teacher.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_card.dart';
import 'package:my_project_new/widgets/app_footer.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/no_data.dart';
import 'package:my_project_new/widgets/refresher_header.dart';
import 'package:my_project_new/widgets/try_again.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('teachers', context),
      body: BlocProvider(
        create: (context) => TeachersCubit()..getTeachers(),
        child: BlocBuilder<TeachersCubit, TeachersState>(
          builder: (context, state) {
            final teachersCubit = context.read<TeachersCubit>();
            if (state is GetTeachersLoading) {
              return const AppLoading();
            }
            if (state is GetTeachersError) {
              return TryAgain(
                  onTap: () {
                    teachersCubit.getTeachers();
                  },
                  message: state.message);
            }
            if (teachersCubit.teachers.isEmpty) {
              return const NoData ();
            }
            return SmartRefresher(
                controller: teachersCubit.refreshController,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () {
                  teachersCubit.page = 1;
                  teachersCubit.getTeachers();
                },
                footer: const AppFooter(),
                onLoading: () {
                  teachersCubit.getTeachers();
                },
                header: const AppRefresherHeader(),
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h,
                      horizontal: 16.w,
                    ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 50),
                    itemBuilder: (context, index) => TeacherCard(
                          teacher: teachersCubit.teachers[index],
                        ),
                    itemCount: teachersCubit.teachers.length));
          },
        ),
      ),
    );
  }
}
