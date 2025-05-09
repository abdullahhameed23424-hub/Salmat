part of 'lessons_cubit.dart';

@immutable
sealed class LessonsState {}

final class LessonsInitial extends LessonsState {}

final class LessonsLoadingState extends LessonsState {}

final class LessonsSuccessState extends LessonsState {}

final class LessonsErrorState extends LessonsState {
  final String message;

  LessonsErrorState({required this.message});
}
