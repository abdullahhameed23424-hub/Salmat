part of 'teachers_cubit.dart';

@immutable
sealed class TeachersState {}

final class TeachersInitial extends TeachersState {}

final class TeachersLoadingState extends TeachersState {}

final class TeachersSuccessState extends TeachersState {}

final class TeachersErrorState extends TeachersState {
  final String message;

  TeachersErrorState({required this.message});
}
