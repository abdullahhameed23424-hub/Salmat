import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/view/screens/comments_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField(
      {super.key,
      this.forPushToCommentsScreen = false,
      required this.commentsCubit});

  final bool
      forPushToCommentsScreen; // to push to comments screen if field clicked in home screen

  final CommentsCubit commentsCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: commentsCubit.formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: TextField(
                controller: commentsCubit.commentController,
                onTap: () {
                  if (forPushToCommentsScreen) {
                    pushTo(context: context, toPage: CommentsScreen());
                  }
                },
                readOnly: forPushToCommentsScreen,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'اكتب تعليق'),
              ),
            ),
            IconButton(
                onPressed: () {
                  commentsCubit.addComment();
                },
                icon: const Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
