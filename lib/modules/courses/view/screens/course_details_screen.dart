import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/dimensions.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field.dart';
import 'package:my_project_new/modules/courses/cubit/courses_cubit.dart';
import 'package:my_project_new/modules/courses/models/course.dart';
import 'package:my_project_new/modules/courses/view/widgets/course_card.dart';
import 'package:my_project_new/modules/courses/view/widgets/unit_card.dart';
import 'package:my_project_new/modules/teachers/view/widgets/teacher_card.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:my_project_new/widgets/try_again.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.course});
  final Course course;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: course.name,
      body: BlocProvider(
        create: (context) =>
            CoursesCubit()..getCourseDetails(courseId: course.id),
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            final CoursesCubit coursesCubit =
                BlocProvider.of<CoursesCubit>(context);
            if (state is GetCourseDetailsLoadingState) {
              return const AppLoading();
            }
            if (state is GetCourseDetailsErrorState) {
              return TryAgain(
                  onTap: () {
                    coursesCubit.getCourseDetails(courseId: course.id);
                  },
                  message: state.message);
            }

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              children: [
                const _CourseHeader(),
                const _InfoCircles(),
                SizedBox(height: 20.h),
                const _CourseDetails(),
                SizedBox(height: 30.h),
                const _Units(),
                SizedBox(height: 30.h),
                const _ReviewSection()
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translate("total_comments", context, args: ["12"]),
            style: titilliumSemiBold.copyWith(color: AppColors.DARK_GRAY)),
        SizedBox(height: 20.h),
        const CommentCard(comment: {
          'name': 'نورمان أحمد',
          'comment': 'لقد أحببته كثيراً، شكراً لكم!',
          'likes': 3,
        }),
        const CommentInputField(forPushToCommentsScreen: true),
      ],
    );
  }
}

class _Units extends StatefulWidget {
  const _Units();

  @override
  State<_Units> createState() => _UnitsState();
}

class _UnitsState extends State<_Units> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: AppColors.PURPLE_LIGHT,

      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      textColor: Colors.black, // ← هذا اللي يضبط اللون عند الفتح
      iconColor: Colors.black, // ← لتوحيد لون الأيقونة المفتوحة
      shape: const RoundedRectangleBorder(),
      tilePadding: EdgeInsets.symmetric(horizontal: 14.w),

      childrenPadding: EdgeInsets.zero,
      title: Text(
        translate('units', context),
        style: TextStyle(
          fontFamily: FONTF_FAMILY,
          // color: Colors.black, // we dont use titilliumBold to use pernt color
          fontSize: Dimensions.FONT_SIZE_DEFAULT,
          fontWeight: FontWeight.w700,
        ),
      ),
      children: List.generate(
        3,
        (index) => UnitCard(index: index),
      ),
    );
  }
}

class _CourseDetails extends StatelessWidget {
  const _CourseDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoColumn(title: translate('description', context), children: const [
          ReadMoreText(
            maxLength: 110,
            text:
                "تحتوي المادة على عدة دروس تأسيسية للدخول الصحيح في المادة ومن ثم الدخول في المنهاج وسيكون هناك أسئلة مؤتمتة واختبارات خلف كل درس",
          ),
        ]),
        _InfoColumn(
          title: translate('requirements', context),
          children: const [
            ReadMoreText(
                maxLength: 110,
                text: "كي تستطيع حضور المادة يجب الاشتراك بها أولا .."),
          ],
        ),
        _InfoColumn(title: translate('teacher', context), children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: TeacherCard(),
          ),
        ])
      ],
    );
  }
}

class _InfoCircles extends StatelessWidget {
  const _InfoCircles();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _InfoCircle(
          image: Images.unitsCircle,
          title: translate('units', context),
          value: '12',
        ),
      ),
      Expanded(
        child: _InfoCircle(
          image: Images.lessonsCircle,
          title: translate("lessons", context),
          value: '8', // You may want to provide a value here
        ),
      ),
      Expanded(
        child: _InfoCircle(
          image: Images.hoursCircle,
          title: translate("hours", context),
          value: '20h', // You may want to provide a value here
        ),
      ),
    ]);
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CourseImage(imagePath: Images.course3),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        "تحتوي المادة على عدة دروس تأسيسية للدخول الصحيح ",
                        style: titilliumSemiBold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            "150.000 SP",
                            style: titilliumBold.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp,
                                color: AppColors.PRIMARY)),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SizedBox(
                                height: 600.h,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 16.h),
                                      child: Text(
                                        translate(
                                            'contact_admin_to_buy', context),
                                        style: titilliumRegular,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          translate("tap_to_contact", context),
                                          style: titilliumBold.copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                        )),
                                    const Spacer(),
                                    Image.asset(
                                      Images.contactWhatsapp,
                                      width: 1.sw,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          // style: IconButton.styleFrom(padding: const EdgeInsets.all(5)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(Images.buyIcon,
                                  width: 80.w,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.PRIMARY, BlendMode.srcIn)),
                              Positioned(
                                top: 25.h,
                                child: Text(
                                  translate('buy', context),
                                  style: titilliumBold.copyWith(
                                      color: AppColors.WHITE),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _InfoColumn({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26, width: 1))),
      child: ExpansionTile(
        shape: const BeveledRectangleBorder(),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: titilliumBold.copyWith(color: AppColors.PRIMARY),
        ),
        children: children,
      ),
    );
  }
}

class _InfoCircle extends StatelessWidget {
  const _InfoCircle(
      {required this.title, required this.value, required this.image});
  final String image;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(title, style: titilliumBold),
      SizedBox(height: 15.h),
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(image, width: 70.w),
          Text(
            value,
            style:
                titilliumRegular.copyWith(fontFamily: "bagel", fontSize: 20.sp),
          )
        ],
      )
    ]);
  }
}
