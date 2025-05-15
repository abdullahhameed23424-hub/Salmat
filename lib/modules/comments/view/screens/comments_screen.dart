import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/comments/cubit/comments_cubit.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_card.dart';
import 'package:my_project_new/modules/comments/view/widgets/comment_input_field.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/widgets/app_loading.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';
import 'package:my_project_new/widgets/modern_loading_dialog.dart';
import 'package:my_project_new/widgets/try_again.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  final GlobalKey<ModernLoadingDialogState> loadingKey =
      GlobalKey<ModernLoadingDialogState>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate('comments', context),
      body: BlocProvider(
        create: (context) => CommentsCubit()..getComments(),
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
                    commentsCubit.getComments(); 
                  },
                  message: state.message); 
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: commentsCubit.comments.length,
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                          delay: Duration(
                              milliseconds: 50 + 50 * Random().nextInt(6)),
                          child: CommentCard(
                              comment: commentsCubit.comments[index]));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: CommentInputField(commentsCubit: commentsCubit),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
