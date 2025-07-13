import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/comments/cubit/comments_cubit.dart';
import 'package:salamat/modules/comments/view/widgets/comment_card.dart';
import 'package:salamat/modules/comments/view/widgets/comment_input_field.dart';
import 'package:salamat/modules/startup/get_started_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/app_loading.dart';
import 'package:salamat/widgets/app_scaffold.dart';
import 'package:salamat/widgets/delete_dialog.dart';
import 'package:salamat/widgets/modern_loading_dialog.dart';
import 'package:salamat/widgets/no_data.dart';
import 'package:salamat/widgets/try_again.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen(
      {super.key,
      required this.getComments,
      required this.commentsCubit,
      this.courseId});
  final void Function() getComments;
  final CommentsCubit commentsCubit;
  final int? courseId;
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey<ModernLoadingDialogState> loadingKey =
      GlobalKey<ModernLoadingDialogState>();

  @override
  void initState() {
    widget.getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('comments', context),
      body: BlocProvider.value(
        value: widget.commentsCubit,
        child: BlocConsumer<CommentsCubit, CommentsState>(
          listener: (context, state) {
            if (state is AddCommentsLoadingState) {
              ModernLoadingDialog.show(context, loadingKey);
            } else if (state is AddCommentsSuccessState) {
              if (loadingKey.currentState != null) {
                Navigator.pop(context);
                customSnackBar(context,
                    success: 1, message: translate("comment_added", context));
              }
            } else if (state is AddCommentsErrorState) {
              Navigator.pop(context);
              customSnackBar(context, success: 0, message: state.message);
            }
          },
          builder: (context, state) {
            final CommentsCubit commentsCubit = context.read<CommentsCubit>();
            if (state is GetCommentsLoadingState) {
              return const AppLoading();
            }
            if (state is GetCommentsErrorState) {
              return TryAgain(
                  onTap: () {
                    if (widget.courseId != null) {
                      commentsCubit.getCommentsByCourseId(
                          courseId: widget.courseId!);
                    } else {
                      commentsCubit.getComments();
                    }
                  },
                  message: state.message);
            }

            return Column(
              children: [
                Expanded(
                  child: commentsCubit.comments.isEmpty
                      ? NoData(title: translate('no_comments', context))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: commentsCubit.comments.length,
                          itemBuilder: (context, index) {
                            return FadeInLeft(
                                delay: Duration(
                                    milliseconds:
                                        50 + 50 * Random().nextInt(6)),
                                child: CommentCard(
                                    commentsCubit: commentsCubit,
                                    onDelete: () {
                                      DeleteDialog.show(context,
                                          title: translate(
                                              "delete_comment", context),
                                          content: translate(
                                              "delete_comment_content",
                                              context), onConfirm: () {
                                        commentsCubit.deleteComment(
                                            commentId: commentsCubit
                                                .comments[index].id);
                                      });
                                    },
                                    comment: commentsCubit.comments[index]));
                          },
                        ),
                ),
                if (AppSharedPreferences.hasToken)
                  Padding(
                      padding: EdgeInsets.all(16.w),
                      child: CommentInputField(
                        commentController: commentsCubit.commentController,
                        formKey: commentsCubit.formKey,
                        submitComment: () {
                          if (widget.courseId != null) {
                            commentsCubit.addCommentByCourseId(
                                courseId: widget.courseId!);
                          } else {
                            commentsCubit.addComment();
                          }
                        },
                      ))
                else
                  TextButton(
                    onPressed: () {
                      pushAndRemoveUntilTo(context,
                          toPage: const GetStartedScreen());
                    },
                    child: Text(
                      'لكتابة تعليق عليك تسجيل الدخول',
                      style: titleHeader.copyWith(
                          color: AppColors.PRIMARY,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.PRIMARY),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
