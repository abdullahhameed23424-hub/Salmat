import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/animation/fade_in_animation.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/lessons/cubit/lessons_cubit.dart';
import 'package:salamat/modules/lessons/models/lesson.dart';
import 'package:salamat/modules/lessons/view/screens/lesson_details_screen.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/view/widgets/counters_squres.dart';
import 'package:salamat/modules/test/view/widgets/result_dialog.dart';
import 'package:salamat/modules/test/view/widgets/test_headar.dart';
import 'package:salamat/modules/test/view/widgets/final_result_card.dart';
import 'package:salamat/modules/test/view/widgets/questions_list.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/utils/screen_recording_utils.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/confirmation_dialog.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/widgets/modern_loading_dialog.dart';
import 'package:salamat/widgets/try_again.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.examId, required this.lesson});
  final int examId;
  final Lesson lesson;
  static final GlobalKey<ModernLoadingDialogState> _loadingDialogKey =
      GlobalKey<ModernLoadingDialogState>();

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    // Enable screen recording blocking for test screen
    ScreenRecordingUtils.enableScreenRecordingBlock();
  }

  @override
  void dispose() {
    // Disable screen recording blocking when leaving test screen
    ScreenRecordingUtils.disableScreenRecordingBlock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('test', context),
      backgroundColor: AppColors.SECONDRY,
      appBarBorderRadius: BorderRadius.zero,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TestCubit()..getTest(widget.examId),
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
                lesson: widget.lesson,
                result: state.result,
                withSkipButton: (state.result.pass != true &&
                    !AppSharedPreferences.isGuest),
                getTest: () {
                  testCubit.getTest(widget.examId);
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
                  testCubit.getTest(widget.examId);
                },
              );
            }

            if (state is StartExamErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  testCubit.createExam(widget.examId);
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
                          if (testCubit.test.result.pass != true) ...[
                            SizedBox(height: 15.h),
                            ElasticInDown(
                              duration: const Duration(milliseconds: 300),
                              child: CustomButton(
                                  borderRadius: BorderRadius.circular(12.r),
                                  label: translate('try_again', context),
                                  onPressed: () {
                                    testCubit.getTest(widget.examId);
                                  }),
                            )
                          ],
                          SizedBox(height: 16.h),
                          if (!AppSharedPreferences.isGuest &&
                              testCubit.test.result.pass != true &&
                              (testCubit.test.studentExam?.attemptCount ?? 0) >
                                  0 &&
                              !(testCubit.test.studentExam?.skipped ??
                                  false)) ...[
                            BlocProvider(
                              create: (context) => LessonsCubit(),
                              child: BlocConsumer<LessonsCubit, LessonsState>(
                                listener: (context, state) {
                                  if (state is SkipTestLoadingState) {
                                    ModernLoadingDialog.show(
                                        context, TestScreen._loadingDialogKey);
                                  } else if (state is SkipTestSuccessState) {
                                    if (TestScreen
                                            ._loadingDialogKey.currentState !=
                                        null) {
                                      Navigator.pop(context);
                                    }
                                    testCubit.getTest(widget.examId);
                                  } else if (state is SkipTestErrorState) {
                                    if (TestScreen
                                            ._loadingDialogKey.currentState !=
                                        null) {
                                      Navigator.pop(context);
                                    }
                                    customSnackBar(context,
                                        success: 0, message: state.message);
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton(
                                      borderRadius: BorderRadius.circular(12.r),
                                      backgroundColor: AppColors.PURPLE_LIGHT,
                                      label: translate(
                                          'skip_test_and_show_answers',
                                          context),
                                      onPressed: () async {
                                        final bool? shouldSkip =
                                            await ConfirmationDialog.show(
                                                context: context,
                                                title: translate(
                                                    'skip_exam', context),
                                                message: translate(
                                                    'skip_exam_message',
                                                    context));

                                        if (shouldSkip == true) {
                                          context.read<LessonsCubit>().skipTest(
                                              lessonId: widget.lesson.id,
                                              unitId: widget.lesson.unitId!);
                                        }
                                      });
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
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
          label: "إرسال الإجابات",
        ),
      ),
    );
  }
}
