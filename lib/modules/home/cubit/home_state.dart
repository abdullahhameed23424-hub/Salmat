part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetHomeLoadingState extends HomeState {}

final class GetHomeSuccessState extends HomeState {}

final class GetHomeErrorState extends HomeState {
  final String message;

  GetHomeErrorState({required this.message});
}
