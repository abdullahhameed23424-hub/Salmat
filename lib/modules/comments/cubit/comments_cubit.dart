import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/comments/models/comments_response.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  List<Comment> comments = [];

  Future<void> getComments() async {
    emit(GetCommentsLoadingState());

    try {
      final Response response =
          await Network.getData(url: Urls.platformComments);

      final CommentsResponse commentsResponse =
          CommentsResponse.fromJson(response.data);
      comments = commentsResponse.data;
      emit(GetCommentsSuccessState());
    } on DioException catch (error) {
      emit(GetCommentsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetCommentsErrorState(message: unknownError()));
    }
  }

  Future<void> getCommentsByCourseId({required int courseId}) async {
    emit(GetCommentsLoadingState());

    try {
      final Response response =
          await Network.getData(url: "${Urls.sectionComments}/$courseId");

      final CommentsResponse commentsResponse =
          CommentsResponse.fromJson(response.data);
      comments = commentsResponse.data;
      emit(GetCommentsSuccessState());
    } on DioException catch (error) {
      emit(GetCommentsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetCommentsErrorState(message: unknownError()));
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController commentController = TextEditingController();

  Future<void> addComment() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AddCommentsLoadingState());
    try {
      await Network.postData(
          url: Urls.platformComments,
          data: {"body": commentController.text.trim()});

      getComments();
      commentController.clear();
      emit(AddCommentsSuccessState());
    } on DioException catch (error) {
      emit(AddCommentsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(AddCommentsErrorState(message: unknownError()));
    }
  }

  Future<void> addCommentByCourseId({required int courseId}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AddCommentsLoadingState());

    try {
      await Network.postData(
          url: "${Urls.sectionComments}/$courseId",
          data: {"body": commentController.text.trim()});
      getCommentsByCourseId(courseId: courseId);
      commentController.clear();

      emit(AddCommentsSuccessState());
    } on DioException catch (error) {
      emit(AddCommentsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(AddCommentsErrorState(message: unknownError()));
    }
  }

  Future<void> deleteComment({required int commentId}) async {
    emit(DeleteCommentsLoadingState());
    try {
      await Network.deleteData(url: "${Urls.comments}/$commentId");
      comments.removeWhere((element) => element.id == commentId);

      emit(DeleteCommentsSuccessState());
    } on DioException catch (error) {
      emit(DeleteCommentsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(DeleteCommentsErrorState(message: unknownError()));
    }
  }
}
