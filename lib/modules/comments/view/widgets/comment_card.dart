import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/read_more_text.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final Function() onDelete;
  final CommentsCubit commentsCubit;
  const CommentCard(
      {super.key,
      required this.comment,
      required this.onDelete,
      required this.commentsCubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 75.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: boxShadow,
            color: Colors.white,
          ),
          child: AspectRatio(
              aspectRatio: 1,
              child: CachedImage(
                image: comment.user?.image ?? "",
                boxFit: BoxFit.cover,
              )),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey.shade400,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user?.username ?? "",
                  style: titilliumBold,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(comment.createdAt),
                    style: titilliumRegular.copyWith(fontSize: 10.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                ReadMoreText(
                  text: comment.body,
                  maxLength: 100,
                ),
                if (comment.user?.id.toString() ==
                    AppSharedPreferences.getUserID)
                  BlocConsumer(
                      bloc: commentsCubit,
                      listener: (context, state) {
                        if (state is DeleteCommentsSuccessState) {
                          customSnackBar(context,
                              success: 1,
                              message: translate("comment_deleted", context));
                        } else if (state is DeleteCommentsErrorState) {
                          customSnackBar(context,
                              success: 0, message: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (commentsCubit.state is DeleteCommentsLoadingState) {
                          return const AppLoading();
                        }
                        return Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: IconButton(
                                onPressed: onDelete,
                                icon:
                                    const Icon(Icons.delete_outline_outlined)));
                      }),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
