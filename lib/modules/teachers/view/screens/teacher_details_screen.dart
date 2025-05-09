import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/teachers/view/widgets/info_item.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_course_card.dart';
import 'package:my_project_new/utils/clipper.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/blue_circle.dart';
import 'package:my_project_new/widgets/read_more_text.dart';

class TeacherDetailsScreen extends StatelessWidget {
  const TeacherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(indent: 80.w, endIndent: 80.w, height: 40.h);
    return AppScaffold(
        appBarBorderRadius: BorderRadius.zero,
        title: translate("about_teacher", context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const _Header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TeacherDetails(divider: divider),
                    divider,
                    const _CoursesLayer(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _CoursesLayer extends StatelessWidget {
  const _CoursesLayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate('courses', context),
          style: titilliumBold.copyWith(color: AppColors.PRIMARY),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 15.h,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return TeacherCourseCard(
              imagePath: index.isEven ? Images.course3 : Images.course4,
              label: "الأشعة $index",
              footerColor: AppColors.appColors[index % 4],
            );
          },
        ),
      ],
    );
  }
}

class TeacherDetails extends StatelessWidget {
  const TeacherDetails({
    super.key,
    required this.divider,
  });

  final Divider divider;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      maxLength: 100,
      text:
          'حاصل على إجازة في الرياضيات من جامعة دمشق، يتمتع بخبرة تزيد عن عشر سنوات في مجال التدريس... ' *
              5,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          ClipPath(
            clipper: TeacherClipper(),
            child: Container(
              padding: EdgeInsets.all(10.w),
              width: 1.sw,
              height: 270.h,
              decoration: const BoxDecoration(color: AppColors.SECONDRY),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      spacing: 5.h,
                      children: [
                        SizedBox(height: 20.h),
                        SizedBox(
                            child: Text(
                          " محمد أحمد جوخدار",
                          style: titilliumBold,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(
                          child: Text("مدرس ثانوي رياضيات",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumBold.copyWith(
                                  color: AppColors.WHITE)),
                        ),
                        SizedBox(height: 10.h),
                        Image.asset(Images.mathPi, width: 50.w)
                      ],
                    ),
                  ),
                  const Spacer(flex: 4)
                ],
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            left: 10.w,
            child: Container(
                width: 160.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    boxShadow: boxShadow,
                    border: Border.all(color: AppColors.PRIMARY),
                    color: AppColors.WHITE,
                    shape: BoxShape.circle),
                child: Image.asset(Images.trainer, width: 145.w)),
          ),
          Positioned(bottom: 23.h, left: -7, child: BlueCircle(diagram: 38.w)),
          Positioned(bottom: 0, left: -24, child: BlueCircle(diagram: 38.w))
        ],
      ),
    );
  }
}

class _LocationAndPhoneRow extends StatelessWidget {
  const _LocationAndPhoneRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        InfoItem(
          icon: Icons.location_on_outlined,
          text: 'دمشق، المهاجرين',
        ),
        InfoItem(
          icon: Icons.phone_outlined,
          text: '0974156247',
        ),
      ],
    );
  }
}

class _BirthAndEmailRow extends StatelessWidget {
  const _BirthAndEmailRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        InfoItem(
          icon: Icons.cake_outlined,
          text: '12-12-2000',
        ),
        InfoItem(
          icon: Icons.email_outlined,
          text: 'mhd123@gmail.com',
        ),
      ],
    );
  }
}
