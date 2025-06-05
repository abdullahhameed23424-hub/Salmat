import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/lessons/view/screens/lesson_details_screen.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/view/widgets/counters_squres.dart';
import 'package:my_project_new/modules/test/view/widgets/result_dialog.dart';
import 'package:my_project_new/modules/test/view/widgets/test_headar.dart';
import 'package:my_project_new/modules/test/view/widgets/final_result_card.dart';
import 'package:my_project_new/modules/test/view/widgets/questions_list.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/try_again.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, required this.examId});
  final int examId;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('test', context),
      backgroundColor: AppColors.SECONDRY,
      appBarBorderRadius: BorderRadius.zero,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TestCubit()..getTest(examId),
          ),
        ],
        child: BlocConsumer<TestCubit, TestState>(
          listener: (context, state) {
            final TestCubit testCubit = context.read<TestCubit>();
            if (state is StartExamSuccessState) {
            } else if (state is SubmitExamErrorState) {
              customSnackBar(context, success: 0, message: state.message);
            }
            if (state is SubmitExamSuccessState) {
              LessonDetailsScreen.refrshLessonScreen = true;
              ResultDialog.show(
                context,
                result: state.result,
                onTryAgainInFailed: () {
                  Navigator.pop(context);
                  testCubit.getTest(examId);
                },
              );
            }
          },
          builder: (context, state) {
            final TestCubit testCubit = context.read<TestCubit>();
            if (state is GetTestLoadingState) {
              return const AppLoading();
            }
            if (state is StartExamLoadingState) {
              return const AppLoading();
            }
            if (state is GetTestErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  testCubit.getTest(examId);
                },
              );
            }

            if (state is StartExamErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  testCubit.createExam(examId);
                },
              );
            }

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Images.examBack,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomScrollView(
                slivers: [
                  ExamHeader(description: testCubit.test.description),
                  CountersSqures(testCubit: testCubit),
                  QuestionsList(examCubit: testCubit),
                  if (!testCubit.isSolving)
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          FinalResultCard(result: testCubit.test.result),
                        ],
                      ),
                    ),
                  if (state is SubmitExamLoadingState)
                    const SliverToBoxAdapter(child: AppLoading())
                  else if (testCubit.isSolving)
                    SubmitButton(examCubit: testCubit),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.examCubit,
  });
  final TestCubit examCubit;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: CustomButton(
          borderRadius: BorderRadius.circular(15.r),
          backgroundColor: AppColors.LIGHTGRAY,
          buttonStyle: titilliumBold.copyWith(color: AppColors.PRIMARY),
          onPressed: () {
            examCubit.submitExam(examId: examCubit.test.id);
          },
          label: 'تحقق من الإجابات',
        ),
      ),
    );
  }
}
