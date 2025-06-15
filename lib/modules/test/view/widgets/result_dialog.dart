import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/lessons/cubit/lessons_cubit.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/test/models/result.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/confirmation_dialog.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/modern_loading_dialog.dart';

class ResultDialog extends StatelessWidget {
  ResultDialog({
    super.key,
    required this.result,
    required this.getTest,
    required this.lesson,
  });
  final GlobalKey<ModernLoadingDialogState> _loadingDialogKey =
      GlobalKey<ModernLoadingDialogState>();
  final Result result;
  final void Function() getTest;
  final Lesson lesson;
  static void show(BuildContext context,
      {required Result result,
      required void Function() getTest,
      required Lesson lesson}) {
    showDialog(
      context: context,
      builder: (_) => ResultDialog(
        result: result,
        getTest: getTest,
        lesson: lesson,
      ),
    );
  }

  final GlobalKey<ModernLoadingDialogState> loadingKey =
      GlobalKey<ModernLoadingDialogState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: BlocProvider(
          create: (context) => LessonsCubit(),
          child: BlocConsumer<LessonsCubit, LessonsState>(
            listener: (context, state) {
              if (state is SkipTestLoadingState) {
                ModernLoadingDialog.show(context, _loadingDialogKey);
              } else if (state is SkipTestSuccessState) {
                if (_loadingDialogKey.currentState != null) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                getTest();
              } else if (state is SkipTestErrorState) {
                if (_loadingDialogKey.currentState != null) {
                  Navigator.pop(context);
                }
                customSnackBar(context, success: 0, message: state.message);
              }
            },
            builder: (context, state) {
              final LessonsCubit lessonsCubit = context.read<LessonsCubit>();
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElasticIn(
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: result.pass == true
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          result.pass == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: AppColors.WHITE,
                          size: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      result.pass == true
                          ? translate('passed', context)
                          : translate('failed', context),
                      style: titilliumBold.copyWith(
                        color: result.pass == true ? Colors.green : Colors.red,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildRow(
                        translate('exam_degree', context), result.examDegree),
                    _buildRow(
                        translate('your_score', context), result.studentDegree),
                    _buildRow(translate('pass_percentage', context),
                        '${result.examPassPercentage}%'),
                    SizedBox(height: 24.h),
                    if (result.pass != true)
                      CustomButton(
                          borderRadius: BorderRadius.circular(12.r),
                          label: translate('try_again', context),
                          onPressed: () {
                            getTest();
                          }),
                    SizedBox(height: 16.h),
                    if (result.pass == false) ...[
                      CustomButton(
                          borderRadius: BorderRadius.circular(12.r),
                          backgroundColor: AppColors.PURPLE_LIGHT,
                          label:
                              translate('skip_test_and_show_answers', context),
                          onPressed: () async {
                            final bool? shouldSkip =
                                await ConfirmationDialog.show(
                                    context: context,
                                    title: translate('skip_exam', context),
                                    message: translate(
                                        'skip_exam_message', context));

                            if (shouldSkip == true) {
                              lessonsCubit.skipTest(
                                  lessonId: lesson.id, unitId: lesson.unitId);
                            }
                          }),
                      SizedBox(height: 16.h),
                    ],
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      label: translate('close', context),
                      backgroundColor: AppColors.WHITE,
                      buttonStyle:
                          titilliumBold.copyWith(color: AppColors.PRIMARY),
                      borderRadius: BorderRadius.circular(12.r),
                      border: const BorderSide(color: AppColors.PRIMARY),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:", style: titilliumRegular),
          Text(value,
              style: titilliumBold.copyWith(
                  color: AppColors.PRIMARY, fontSize: 16.sp)),
        ],
      ),
    );
  }
}
