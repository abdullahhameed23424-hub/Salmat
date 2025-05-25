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
import 'package:my_project_new/modules/lessons/view/widgets/attachment_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/custom_exam_button.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_buttons_tabbar.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_image_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_video.dart';
import 'package:my_project_new/modules/lessons/view/widgets/resolution_card.dart';
import 'package:my_project_new/modules/test/cubit/test_cubit.dart';
import 'package:my_project_new/modules/test/view/screens/test_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/try_again.dart';

class LessonDetailsScreen extends StatefulWidget {
  const LessonDetailsScreen({super.key, required this.lesson});
  final Lesson lesson;
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarBorderRadius: BorderRadius.zero,
      title: widget.lesson.name,
      body: BlocProvider(
        create: (context) => LessonsCubit()
          ..getLessonDetails(
              lessonId: widget.lesson.id, unitId: widget.lesson.unitId),
        child: BlocBuilder<LessonsCubit, LessonsState>(
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

            final bool isPassed =
                lessonsCubit.lessonDetails.test?.result.pass == true;
            return ListView(
              clipBehavior: Clip.none,
              children: <Widget>[
                LessonVideo(lesson: lessonsCubit.lessonDetails),
                ServerOptions(),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      clipBehavior: Clip.none,
                      transform: Matrix4.translationValues(0, 85.h, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 22.h),
                          _LessonDscription(
                              lessonsCubit.lessonDetails.description),
                          _LessonTaps(
                              controller: controller,
                              lessonsCubit: lessonsCubit),
                          if (lessonsCubit.lessonDetails.examId != null)
                            DoExamButton(
                                color: isPassed ? AppColors.LIGHT_GREEN : null,
                                label: isPassed
                                    ? translate('view_exam', context)
                                    : translate('do_exam', context),
                                onTap: () {
                                  pushTo(
                                      context: context,
                                      toPage: TestScreen(
                                          examId: lessonsCubit
                                              .lessonDetails.examId!));
                                }),
                          NextAndLastLessonButtons(lessonsCubit: lessonsCubit),
                        ],
                      ),
                    ),
                    _LessonHeader(lessonsCubit.lessonDetails),
                  ],
                ),
                SizedBox(height: 80.h)
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

            return CustomButton(
                backgroundColor: AppColors.SECONDRY,
                buttonStyle: titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                label: translate('next_lesson', context),
                onPressed:
                    lessonsCubit.buttonStatus != NextLessonButtonStatus.DISABLED
                        ? () {
                            lessonsCubit.openNextLessons();
                          }
                        : null);
          })),
          SizedBox(width: 35.w),
          Expanded(
              child: CustomButton(
                  backgroundColor: AppColors.LIGHT_GREEN,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('previous_lesson', context),
                  onPressed: () {})),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LessonButtonsTabbar(
          controller: widget.controller,
          items: LessonsCubit.lessonButtonsTitles,
          onTap: (index) {
            LessonsCubit.changeSelectedButton(index: index);
            setState(() {});
          },
        ),
        if (LessonsCubit.selectedButton == 0)
          _LessonImages(widget.lessonsCubit.lessonDetails)
        else if (LessonsCubit.selectedButton == 1)
          _LessonAttachments(widget.lessonsCubit.lessonDetails)
      ],
    );
  }
}

class _LessonImages extends StatelessWidget {
  final Lesson lesson;

  const _LessonImages(this.lesson);
  @override
  Widget build(BuildContext context) {
    if (lesson.images.isEmpty) {
      return SizedBox(
        height: 180.h,
        child: Center(
          child: ZoomIn(
            child: Text(
              translate('no_images', context),
              style: titilliumBold,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h, top: 5),
          itemCount: lesson.images.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) =>
              LessonImageCard(imagePath: lesson.images[index])),
    );
  }
}

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
