import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/courses/cubit/courses_cubit.dart';
import 'package:my_project_new/modules/lessons/cubit/lessons_cubit.dart';
import 'package:my_project_new/modules/lessons/view/widgets/attachment_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/custom_exam_button.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_buttons_tabbar.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_image_card.dart';
import 'package:my_project_new/modules/lessons/view/widgets/lesson_video.dart';
import 'package:my_project_new/modules/lessons/view/widgets/resolution_card.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/widgets/read_more_text.dart';

class LessonsDetailsScreen extends StatefulWidget {
  const LessonsDetailsScreen({super.key});

  @override
  State<LessonsDetailsScreen> createState() => _LessonsDetailsScreenState();
}

class _LessonsDetailsScreenState extends State<LessonsDetailsScreen>
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
      backgroundColor: AppColors.BLACK,
      title: "الأشعة 1",
      body: ListView(
        clipBehavior: Clip.none,
        children: <Widget>[
          LessonVideo(oneCourseCubit: CoursesCubit()),
          const ServerOptions(),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                clipBehavior: Clip.none,
                transform: Matrix4.translationValues(0, 85.h, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(height: 22.h),
                    const _LessonDscription(),
                    _LessonTaps(controller: controller),
                    const DoExamButton(),
                    const NextAndLastLessonButtons(),
                  ],
                ),
              ),
              const _LessonHeader(),
            ],
          ),
          SizedBox(height: 80.h)
        ],
      ),
    );
  }
}

class NextAndLastLessonButtons extends StatelessWidget {
  const NextAndLastLessonButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.LIGHTGRAY, borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      child: Row(
        children: <Widget>[
          Expanded(
              child: CustomButton(
                  backgroundColor: AppColors.SECONDRY,
                  buttonStyle:
                      titilliumBold.copyWith(color: AppColors.DARK_GRAY),
                  label: translate('next_lesson', context),
                  onPressed: () {})),
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
  });

  final TabController controller;

  @override
  State<_LessonTaps> createState() => _LessonTapsState();
}

class _LessonTapsState extends State<_LessonTaps> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          _VideoResolutions()
        else if (LessonsCubit.selectedButton == 1)
          _LessonAttachments()
        else if (LessonsCubit.selectedButton == 2)
          _LessonImages(),
      ],
    );
  }
}

class _LessonImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h, top: 5),
          itemCount: 3,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) => const LessonImageCard()),
    );
  }
}

class _LessonAttachments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 10.h, top: 2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.2, mainAxisSpacing: 15.h),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const AttachmentCard(
              imagePath: Images.arabic, label: "ورقة عمل");
        },
      ),
    );
  }
}

class _LessonDscription extends StatelessWidget {
  const _LessonDscription();

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
          ReadMoreText(
              maxLength: 110,
              text:
                  "في هذا الفيديو الشيق، نستعرض لكم مقدمة عن أساسيات مادة الأشعة" *
                      5),
        ],
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      // color: Colors.black,
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
                'الدرس الأول: تأسيس 1',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titilliumBold.copyWith(
                    color: AppColors.WHITE, fontSize: 14.sp),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    translate("duration_label", context, args: ['00:16:40']),
                    style: titilliumBold.copyWith(
                        color: AppColors.WHITE, fontSize: 14.sp),
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(Images.whiteShape, width: 100.w),
                      // Text(translate('paid', context),
                      //     style:
                      //         titilliumBold.copyWith(color: AppColors.PRIMARY))
                    ],
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
      decoration: const BoxDecoration(color: Colors.black),
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
                  style: titilliumSemiBold.copyWith(
                      fontSize: 8.sp, color: Colors.white),
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
            borderColor: Colors.white,
            selectedColor: Colors.white,
            fillColor: AppColors.PRIMARY,
            textStyle: titilliumBold.copyWith(fontSize: 8.sp),
            color: Colors.white,
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
