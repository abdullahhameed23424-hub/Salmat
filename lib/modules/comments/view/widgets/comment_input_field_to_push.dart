import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/view/screens/comments_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class CommentInputFieldToPush extends StatelessWidget {
  const CommentInputFieldToPush(
      {super.key, required this.commentsCubit, required this.getComments, this.courseId});

  final int? courseId;
  final CommentsCubit commentsCubit;
  final Function( ) getComments; 
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: () {
                pushTo(
                    context: context,
                    toPage: CommentsScreen(
                        commentsCubit: commentsCubit,
                        courseId: courseId,
                        getComments: () {
                          getComments();
                        }));
              },
              readOnly: true,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'اكتب تعليق'),
            ),
          ),
          const Icon(Icons.send)
        ],
      ),
    );
  }
}
