part of 'test_cubit.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {}

final class GetTestLoadingState extends TestState {}

final class GetTestSuccessState extends TestState {}

final class GetTestErrorState extends TestState {
  final String message;

  GetTestErrorState({required this.message});
}

final class StartExamLoadingState extends TestState {}

final class StartExamSuccessState extends TestState {}

final class StartExamErrorState extends TestState {
  final String message;
   
  StartExamErrorState({required this.message });
}

final class SubmitExamLoadingState extends TestState {}

final class SubmitExamSuccessState extends TestState {}

final class SubmitExamErrorState extends TestState {
  final String message;

  SubmitExamErrorState({required this.message});
}
