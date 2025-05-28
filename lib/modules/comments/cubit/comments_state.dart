part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class GetCommentsLoadingState extends CommentsState {}

final class GetCommentsSuccessState extends CommentsState {}

final class GetCommentsErrorState extends CommentsState {
  final String message;

  GetCommentsErrorState({required this.message});
}

final class AddCommentsLoadingState extends CommentsState {}

final class AddCommentsSuccessState extends CommentsState {}

final class AddCommentsErrorState extends CommentsState {
  final String message;

  AddCommentsErrorState({required this.message});
}



final class DeleteCommentsLoadingState extends CommentsState {}

final class DeleteCommentsSuccessState extends CommentsState {}

final class DeleteCommentsErrorState extends CommentsState {
  final String message;
  DeleteCommentsErrorState({required this.message});
}
