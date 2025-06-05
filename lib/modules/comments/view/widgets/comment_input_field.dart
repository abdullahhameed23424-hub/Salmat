import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField(
      {super.key,
      required this.submitComment,
      required this.formKey,
      required this.commentController});

  final void Function() submitComment;
  final GlobalKey<FormState> formKey;
  final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                controller: commentController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'اكتب تعليق'),
              ),
            ),
            IconButton(
                onPressed: () {
                  submitComment();
                },
                icon: const Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
