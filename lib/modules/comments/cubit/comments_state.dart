part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsLoadingState extends CommentsState {}

final class CommentsSuccessState extends CommentsState {}

final class CommentsErrorState extends CommentsState {
  final String message;

  CommentsErrorState({required this.message});
}
