import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/lessons/cubit/lessons_cubit.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/lessons/models/next_lesson_button_status.dart';
import 'package:my_project_new/modules/lessons/view/screens/lessonss_screen.dart';
import 'package:my_project_new/modules/lessons/view/widgets/attachment_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/custom_exam_button.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_buttons_tabbar.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_image_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_video.dart';
import 'package:my_project_new/modules/lessons/view/widgets/resolution_card.dart';
import 'package:my_project_new/modules/test/view/screens/test_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/confirmation_dialog.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/modern_loading_dialog.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/try_again.dart';

class LessonDetailsScreen extends StatefulWidget {
  const LessonDetailsScreen({super.key, required this.lesson});
  final Lesson lesson;
  static bool refrshLessonScreen = false;
  @override
  State<LessonDetailsScreen> createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(
        length: LessonsCubit.lessonButtonsTitles.length, vsync: this);

    super.initState();
  }

  final GlobalKey<ModernLoadingDialogState> _loadingDialogKey =
      GlobalKey<ModernLoadingDialogState>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBarBorderRadius: BorderRadius.zero,
      title: widget.lesson.name,
      body: BlocProvider(
        create: (context) => LessonsCubit()
          ..getLessonDetails(
              lessonId: widget.lesson.id, unitId: widget.lesson.unitId),
        child: BlocConsumer<LessonsCubit, LessonsState>(
          listener: (context, state) {
            final LessonsCubit lessonsCubit = context.read<LessonsCubit>();
            if (state is OpenNextLessonErrorState) {
              customSnackBar(context, success: 0, message: state.message);
            } else if (state is OpenNextLessonSuccessState) {
              LessonsScreen.refrshLessonsScreen = true;
              if (lessonsCubit.buttonStatus ==
                  NextLessonButtonStatus.OPEN_NEXT_UNIT) {
                Navigator.pop(context,
                    {"next_unit_id": lessonsCubit.lessonDetails.nextUnitId!});
                customSnackBar(context, success: 1, message: "تم إنهاء الوحدة");
              } else if (lessonsCubit.buttonStatus ==
                  NextLessonButtonStatus.OPEN_AND_MOVE) {
                lessonsCubit.getLessonDetails(
                    lessonId: state.nextLessonId,
                    unitId: lessonsCubit.lessonDetails.unitId);
              }
            } else if (state is SkipTestLoadingState) {
              ModernLoadingDialog.show(context, _loadingDialogKey);
            } else if (state is SkipTestSuccessState) {
              LessonsScreen.refrshLessonsScreen = true;
              if (_loadingDialogKey.currentState != null) {
                Navigator.pop(context);
              }
              lessonsCubit.getLessonDetails(
                  lessonId: lessonsCubit.lessonDetails.id,
                  unitId: lessonsCubit.lessonDetails.unitId);

              pushTo(
                  context: context,
                  toPage:
                      TestScreen(examId: lessonsCubit.lessonDetails.exam!.id));
            } else if (state is SkipTestErrorState) {
              if (_loadingDialogKey.currentState != null) {
                Navigator.pop(context);
              }
              customSnackBar(context, success: 0, message: state.message);
            }
          },
          builder: (context, state) {
            final LessonsCubit lessonsCubit = context.read<LessonsCubit>();
            if (state is GetLessonDetailsLoadingState) {
              return const AppLoading();
            }
            if (state is GetLessonDetailsErrorState) {
              return TryAgain(
                  onTap: () {
                    lessonsCubit.getLessonDetails(
                        lessonId: widget.lesson.id,
                        unitId: widget.lesson.unitId);
                  },
                  message: state.message);
            }
            final bool thereIsTest = lessonsCubit.lessonDetails.exam != null;
            final bool isPassed =
                ((lessonsCubit.lessonDetails.exam!.result.pass == true) ||
                        (lessonsCubit.lessonDetails.exam!.studentExam.skipped)
                    ? true
                    : false);
            return ListView(
              clipBehavior: Clip.none,
              children: <Widget>[
                LessonVideo(lesson: lessonsCubit.lessonDetails),
                const ServerOptions(),
                _LessonHeader(lessonsCubit.lessonDetails),
                Column(
                  children: [
                    SizedBox(height: 22.h),
                    _LessonDscription(lessonsCubit.lessonDetails.description),
                    _LessonTaps(
                        controller: controller, lessonsCubit: lessonsCubit),
                    if (thereIsTest) ...[
                      DoExamButton(
                          color: isPassed ? AppColors.LIGHT_GREEN : null,
                          label: isPassed
                              ? translate('view_exam', context)
                              : lessonsCubit.lessonDetails.exam?.isSolving ==
                                      true
                                  ? "إتمام الاختبار"
                                  : translate('do_exam', context),
                          onTap: () async {
                            LessonDetailsScreen.refrshLessonScreen = false;
                            await pushTo(
                                context: context,
                                toPage: TestScreen(
                                    examId:
                                        lessonsCubit.lessonDetails.examId!));

                            if (LessonDetailsScreen.refrshLessonScreen) {
                              lessonsCubit.getLessonDetails(
                                  lessonId: lessonsCubit.lessonDetails.id,
                                  unitId: lessonsCubit.lessonDetails.unitId);
                            }
                          }),
                      SizedBox(height: 15.h),
                      if (thereIsTest &&
                          !lessonsCubit.lessonDetails.exam!.isSolving &&
                          lessonsCubit.lessonDetails.exam!.result.pass ==
                              null &&
                          lessonsCubit.lessonDetails.exam!.studentExam
                                  .attemptCount >
                              0 &&
                          !lessonsCubit.lessonDetails.exam!.studentExam.skipped)
                        CustomButton(
                            backgroundColor: AppColors.PURPLE_LIGHT,
                            label: translate(
                                'skip_test_and_show_answers', context),
                            onPressed: () async {
                              final bool? shouldSkip =
                                  await ConfirmationDialog.show(
                                      context: context,
                                      title: translate('skip_exam', context),
                                      message: translate(
                                          'skip_exam_message', context));

                              if (shouldSkip == true) {
                                lessonsCubit.skipTest(
                                    lessonId: lessonsCubit.lessonDetails.id,
                                    unitId: lessonsCubit.lessonDetails.unitId);
                              }
                            }),
                    ],
                    NextAndLastLessonButtons(lessonsCubit: lessonsCubit),
                  ],
                ),
                SizedBox(height: 40.h)
              ],
            );
          },
        ),
      ),
    );
  }
}

class NextAndLastLessonButtons extends StatelessWidget {
  const NextAndLastLessonButtons({
    super.key,
    required this.lessonsCubit,
  });

  final LessonsCubit lessonsCubit;
  @override
  Widget build(BuildContext context) {
    print("lessonsCubit.buttonStatus: ${lessonsCubit.buttonStatus}");
    return Container(
      decoration: BoxDecoration(
          color: AppColors.LIGHTGRAY, borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      child: Row(
        children: <Widget>[
          Expanded(child: Builder(builder: (context) {
            if (lessonsCubit.state is OpenNextLessonLoadingState) {
              return const AppLoading();
            }

            if (lessonsCubit.buttonStatus ==
                NextLessonButtonStatus.COURSE_END) {
              return CustomButton(
                  backgroundColor: AppColors.SECONDRY,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('next_lesson', context),
                  onPressed: () {
                    customSnackBar(context,
                        success: 0, message: translate('course_end', context));
                  });
            } else if (lessonsCubit.buttonStatus ==
                NextLessonButtonStatus.DO_TEST_FIRST) {
              return CustomButton(
                  backgroundColor: Colors.grey.shade300,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('next_lesson', context),
                  onPressed: () {
                    customSnackBar(context,
                        success: 0,
                        message: translate('do_test_first', context));
                  });
            } else if (lessonsCubit.buttonStatus ==
                NextLessonButtonStatus.OPEN_NEXT_UNIT) {
              return CustomButton(
                  backgroundColor: AppColors.SECONDRY,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('next_unit', context),
                  onPressed: () {
                    lessonsCubit.openNextLessons();
                  });
            } else {
              return CustomButton(
                  backgroundColor: AppColors.SECONDRY,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('next_lesson', context),
                  onPressed: (lessonsCubit.buttonStatus !=
                          NextLessonButtonStatus.DISABLED)
                      ? () {
                          lessonsCubit.openNextLessons();
                        }
                      : null);
            }
          })),
          SizedBox(width: 35.w),
          Expanded(
              child: CustomButton(
                  backgroundColor: AppColors.LIGHT_GREEN,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('previous_lesson', context),
                  onPressed: (lessonsCubit.lessonDetails.previousLessonId !=
                              null &&
                          lessonsCubit.lessonDetails.previousLessonId != -1)
                      ? () {
                          lessonsCubit.getLessonDetails(
                              lessonId:
                                  lessonsCubit.lessonDetails.previousLessonId!,
                              unitId: lessonsCubit.lessonDetails.unitId);
                        }
                      : null)),
        ],
      ),
    );
  }
}

class _LessonTaps extends StatefulWidget {
  const _LessonTaps({
    required this.controller,
    required this.lessonsCubit,
  });
  final LessonsCubit lessonsCubit;
  final TabController controller;

  @override
  State<_LessonTaps> createState() => _LessonTapsState();
}

class _LessonTapsState extends State<_LessonTaps> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          "المرفقات",
          style: titilliumBold,
        ),
        children: [_LessonAttachments(widget.lessonsCubit.lessonDetails)],
      ),
    );
  }
}

// class _LessonImages extends StatelessWidget {
//   final Lesson lesson;

//   const _LessonImages(this.lesson);
//   @override
//   Widget build(BuildContext context) {
//     if (lesson.images.isEmpty) {
//       return SizedBox(
//         height: 180.h,
//         child: Center(
//           child: ZoomIn(
//             child: Text(
//               translate('no_images', context),
//               style: titilliumBold,
//             ),
//           ),
//         ),
//       );
//     }
//     return SizedBox(
//       height: 180.h,
//       child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding:
//               EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h, top: 5),
//           itemCount: lesson.images.length,
//           separatorBuilder: (context, index) => SizedBox(width: 12.w),
//           itemBuilder: (context, index) =>
//               LessonImageCard(imagePath: lesson.images[index])),
//     );
//   }
// }

class _LessonAttachments extends StatelessWidget {
  final Lesson lesson;

  const _LessonAttachments(this.lesson);
  @override
  Widget build(BuildContext context) {
    if (lesson.files.isEmpty) {
      return SizedBox(
        height: 180.h,
        child: Center(
          child: FadeIn(
            child: Text(
              translate('no_attachments', context),
              style: titilliumBold,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 180.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 10.h, top: 2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.2, mainAxisSpacing: 15.h),
        itemCount: lesson.files.length,
        itemBuilder: (BuildContext context, int index) {
          return AttachmentCard(file: lesson.files[index]);
        },
      ),
    );
  }
}

class _LessonDscription extends StatelessWidget {
  const _LessonDscription(this.description);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          translate("description", context),
          style: titilliumBold,
        ),
        children: [
          ReadMoreText(maxLength: 110, text: description),
        ],
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader(this.lesson);
  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      color: Colors.white,
      child: Container(
          width: 1.sw,
          height: 105.h,
          margin: EdgeInsets.only(left: 16.w, right: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
              ],
              color: AppColors.SECONDRY,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.h),
              Text(
                lesson.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titilliumBold.copyWith(
                    color: AppColors.WHITE, fontSize: 14.sp),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    translate("duration_label", context, args: [lesson.time]),
                    style: titilliumBold.copyWith(
                        color: AppColors.WHITE, fontSize: 14.sp),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 30.sp,
                                )),
                            _VideoResolutions(),
                          ],
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(Images.whiteShape, width: 100.w),
                        Text(translate('download', context),
                            style: titilliumBold.copyWith(
                                color: AppColors.PRIMARY))
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w)
                ],
              ),
            ],
          )),
    );
  }
}

class _VideoResolutions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 22.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.77,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return const ResolutionCard();
      },
    );
  }
}

class ServerOptions extends StatefulWidget {
  const ServerOptions({super.key});

  @override
  State<ServerOptions> createState() => _ServerOptionsState();
}

class _ServerOptionsState extends State<ServerOptions> {
  bool isMainSelected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate('use_backup_server', context),
                  textAlign: TextAlign.center,
                  style: titilliumBold.copyWith(fontSize: 8.sp),
                ),
              ],
            ),
          ),
          ToggleButtons(
            selectedBorderColor: AppColors.PRIMARY,
            isSelected: [isMainSelected, !isMainSelected],
            onPressed: (index) {
              setState(() {
                isMainSelected = index == 0;
              });
            },
            borderRadius: BorderRadius.circular(20),
            borderColor: Colors.grey,
            selectedColor: Colors.white,
            fillColor: AppColors.PRIMARY,
            textStyle: titilliumBold.copyWith(fontSize: 8.sp),
            color: Colors.black,
            constraints: BoxConstraints(
              minHeight: 30.h,
              minWidth: 60.w,
            ),
            children: const [
              Text(' الرئيسي'),
              Text(' الاحتياطي'),
            ],
          ),
        ],
      ),
    );
  }
}
