import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/dimensions.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/comments/cubit/comments_cubit.dart';
import 'package:salamat/modules/comments/view/screens/comments_screen.dart';
import 'package:salamat/modules/comments/view/widgets/comment_card.dart';
import 'package:salamat/modules/comments/view/widgets/comment_input_field_to_push.dart';
import 'package:salamat/modules/courses/cubit/courses_cubit.dart';
import 'package:salamat/modules/courses/models/course.dart';
import 'package:salamat/modules/courses/models/unit.dart';
import 'package:salamat/modules/courses/view/widgets/unit_card.dart';
import 'package:salamat/modules/teachers/view/widgets/teacher_card.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/cached_image.dart';
import 'package:salamat/widgets/contact_with_admin_dialog.dart';
import 'package:salamat/widgets/delete_dialog.dart';
import 'package:salamat/widgets/no_data.dart';
import 'package:salamat/widgets/read_more_text.dart';
import 'package:salamat/widgets/try_again.dart';

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
        child: BlocConsumer<CoursesCubit, CoursesState>(
          listener: (context, state) {
            if (state is SubscribeToCourseSuccessState) {
              context
                  .read<CoursesCubit>()
                  .getCourseDetails(courseId: course.id);
            }
            if (state is SubscribeToCourseErrorState) {
              customSnackBar(context, success: 0, message: state.message);
            }
          },
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
                _CourseHeader(coursesCubit.couresDetails, coursesCubit),
                _InfoCircles(coursesCubit.couresDetails, coursesCubit.units),
                _CourseDetails(course: coursesCubit.couresDetails),
                SizedBox(height: 20.h),
                _Units(coursesCubit.units, coursesCubit.couresDetails),
                SizedBox(height: 20.h),
                _ReviewSection(coursesCubit),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReviewSection extends StatefulWidget {
  const _ReviewSection(this.coursesCubit);
  final CoursesCubit coursesCubit;

  @override
  State<_ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<_ReviewSection> {
  final CommentsCubit commentsCubit = CommentsCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Text(
              translate("total_comments", context, args: [
                widget.coursesCubit.couresDetails.comments.length.toString()
              ]),
              style: titilliumBold.copyWith(color: AppColors.DARK_GRAY),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  pushTo(
                      context: context,
                      toPage: CommentsScreen(
                          courseId: widget.coursesCubit.couresDetails.id,
                          commentsCubit: commentsCubit,
                          getComments: () {
                            commentsCubit.getCommentsByCourseId(
                                courseId: widget.coursesCubit.couresDetails.id);
                          }));
                },
                child: Row(
                  children: [
                    Text(
                      translate("view_all", context),
                      style: titilliumBold.copyWith(
                        color: AppColors.PURPLE_LIGHT,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.PURPLE_LIGHT,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20.sp,
                      color: AppColors.PURPLE_LIGHT,
                    )
                  ],
                ))
          ],
        ),
        SizedBox(height: 20.h),
        if (widget.coursesCubit.couresDetails.comments.isNotEmpty)
          CommentCard(
            commentsCubit: commentsCubit,
            comment: widget.coursesCubit.couresDetails.comments[0],
            onDelete: () {
              DeleteDialog.show(context,
                  title: translate("delete_comment", context),
                  content: translate("delete_comment_content", context),
                  onConfirm: () async {
                await commentsCubit.deleteComment(
                    commentId:
                        widget.coursesCubit.couresDetails.comments.first.id);
                if (commentsCubit.state is DeleteCommentsSuccessState) {
                  widget.coursesCubit.couresDetails.comments.removeAt(0);
                  setState(() {});
                }
              });
            },
          ),
        CommentInputFieldToPush(
          courseId: widget.coursesCubit.couresDetails.id,
          commentsCubit: commentsCubit,
          getComments: () {
            commentsCubit.getCommentsByCourseId(
                courseId: widget.coursesCubit.couresDetails.id);
          },
        ),
      ],
    );
  }
}

class _Units extends StatelessWidget {
  const _Units(this.units, this.course);
  final List<Unit> units;
  final Course course;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate('units', context),
          style: TextStyle(
              fontFamily: FONTF_FAMILY,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              fontWeight: FontWeight.w700,
              color: AppColors.PRIMARY),
        ),
        ...List.generate(
          units.length,
          (index) => UnitCard(
            unit: units[index],
            isSubscribed: course.subscribed,
          ),
        )
      ],
    );
    // return  ExpansionTile(
    //   collapsedBackgroundColor: AppColors.PURPLE_LIGHT,
    //
    //   initiallyExpanded: true,
    //
    //   collapsedShape:
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    //   collapsedIconColor: Colors.white,
    //   collapsedTextColor: Colors.white,
    //   textColor: Colors.black, // ← هذا اللي يضبط اللون عند الفتح
    //   iconColor: Colors.black, // ← لتوحيد لون الأيقونة المفتوحة
    //   shape: const RoundedRectangleBorder(),
    //   tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
    //   // backgroundColor: AppColors.PURPLE_LIGHT,
    //
    //   childrenPadding: EdgeInsets.zero,
    //   title: Text(
    //     translate('units', context),
    //     style: TextStyle(
    //       fontFamily: FONTF_FAMILY,
    //       fontSize: Dimensions.FONT_SIZE_DEFAULT,
    //       fontWeight: FontWeight.w700,
    //     ),
    //   ),
    //   children: List.generate(
    //     units.length,
    //     (index) => UnitCard(
    //       unit: units[index],
    //       isSubscribed: course.subscribed,
    //     ),
    //   ),
    // );
  }
}

class _CourseDetails extends StatelessWidget {
  final Course course;
  const _CourseDetails({required this.course});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoColumn(title: translate('description', context), children: [
          ReadMoreText(
            maxLength: 110,
            text: course.description,
          ),
        ]),
        _InfoColumn(
          title: translate('requirements', context),
          children: [
            ReadMoreText(maxLength: 110, text: course.requirements),
          ],
        ),
        _InfoColumn(title: translate('teacher', context), children: [
          ...List.generate(
            course.teachers.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              child: TeacherCard(teacher: course.teachers[index]),
            ),
          )
        ])
      ],
    );
  }
}

class _InfoCircles extends StatelessWidget {
  const _InfoCircles(this.course, this.units);
  final Course course;
  final List<Unit> units;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _InfoCircle(
          image: Images.unitsCircle,
          title: translate('units', context),
          value: units.length.toString(),
        ),
      ),
      Expanded(
        child: _InfoCircle(
          image: Images.lessonsCircle,
          title: translate("lessons", context),
          value: course.lessonsCount.toString(),
        ),
      ),
      // Expanded(
      //   child: _InfoCircle(
      //     image: Images.hتoursCircle,
      //     title: translate("hours", context),
      //     value: course.totalLessonsTime,
      //   ),
      // ),
    ]);
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader(this.course, this.courseCubit);
  final Course course;
  final CoursesCubit courseCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(top: 0.h),
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // width: 0.78.sw,
                decoration: BoxDecoration(
                  boxShadow: boxShadow,
                  color: AppColors.WHITE,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedImage(
                    borderRadius: BorderRadius.circular(12),
                    image: course.image,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReadMoreText(text: course.description, maxLength: 70),
                    // if (!course.subscribed)
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // children: [
                    // Text(
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     course.isFree
                    //         ? translate('free', context)
                    //         : "${course.totalPrice} ل.س",
                    //     style: titilliumBold.copyWith(
                    //         fontWeight: FontWeight.w900,
                    //         fontSize: 18.sp,
                    //         color: AppColors.PRIMARY)),
                    // InkWell(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       context: context,
                    //       builder: (context) =>
                    //           const ContactWithAdminDialog(),
                    //     );
                    //   },
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       SvgPicture.asset(Images.buyIcon,
                    //           width: 90.w,
                    //           colorFilter: ColorFilter.mode(
                    //               course.isFree
                    //                   ? Colors.green
                    //                   : AppColors.PRIMARY,
                    //               BlendMode.srcIn)),
                    //       Positioned(
                    //         child: Text(
                    //           translate('subscribe', context),
                    //           style: titilliumBold.copyWith(
                    //               color: AppColors.WHITE),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
                    //   ],
                    // )
                    // else
                    //  SizedBox(height: 15.h),
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
