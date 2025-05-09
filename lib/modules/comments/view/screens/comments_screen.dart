import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class CommentsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> comments = List.generate(3, (_) {
    return {
      'name': 'نورمان أحمد',
      'comment': 'لقد أحببته كثيراً، شكراً لكم!',
      'likes': 3,
    };
  });

  CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('comments', context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return FadeInLeft(
                    delay:
                        Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
                    child: CommentCard(comment: comments[index]));
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CommentInputField(),
          )
        ],
      ),
    );
  }
}
