part of 'exam_cubit.dart';

@immutable
sealed class ExamState {}

final class ExamInitial extends ExamState {}

final class ExamLoadingState extends ExamState {}

final class ExamSuccessState extends ExamState {}

final class ExamErrorState extends ExamState {
  final String message;

  ExamErrorState({required this.message});
}
