part of 'subjects_cubit.dart';

@immutable
sealed class SubjectsState {}

final class SubjectsInitial extends SubjectsState {}

final class GetSubjectsLoadingState extends SubjectsState {}

final class GetSubjectsSuccessState extends SubjectsState {}

final class GetSubjectsErrorState extends SubjectsState {
  final String message;

  GetSubjectsErrorState({required this.message});
}
