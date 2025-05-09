part of 'info_cubit.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}

final class InfoLoadingState extends InfoState {}

final class InfoSuccessState extends InfoState {}

final class InfoErrorState extends InfoState {
  final String message;

  InfoErrorState({required this.message});
}
