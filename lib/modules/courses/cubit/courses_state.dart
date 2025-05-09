part of 'courses_cubit.dart';

@immutable
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}

final class GetCoursesLoadingState extends CoursesState {}

final class GetCoursesSuccessState extends CoursesState {}

final class GetCoursesErrorState extends CoursesState {
  final String message;
   GetCoursesErrorState({required this.message});
}
