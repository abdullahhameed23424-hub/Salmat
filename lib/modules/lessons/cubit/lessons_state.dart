part of 'lessons_cubit.dart';

@immutable
sealed class LessonsState {}

final class LessonsInitial extends LessonsState {}

final class GetLessonsLoadingState extends LessonsState {}

final class GetLessonsSuccessState extends LessonsState {}

final class GetLessonsErrorState extends LessonsState {
  final String message;

  GetLessonsErrorState({required this.message});
}

final class GetLessonDetailsLoadingState extends LessonsState {}

final class GetLessonDetailsSuccessState extends LessonsState {}

final class GetLessonDetailsErrorState extends LessonsState {
  final String message;

  GetLessonDetailsErrorState({required this.message});
}

final class OpenNextLessonLoadingState extends LessonsState {}

final class OpenNextLessonSuccessState extends LessonsState {
  final int nextLessonId;
  OpenNextLessonSuccessState({required this.nextLessonId});
}

final class OpenNextLessonErrorState extends LessonsState {
  final String message;
  OpenNextLessonErrorState({required this.message});
}
