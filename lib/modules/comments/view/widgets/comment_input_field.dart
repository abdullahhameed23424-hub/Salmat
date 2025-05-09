import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/modules/comments/view/screens/comments_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField({super.key, this.forPushToCommentsScreen = false});
  final bool forPushToCommentsScreen;
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
          const Icon(Icons.send),
        ],
      ),
    );
  }
}
