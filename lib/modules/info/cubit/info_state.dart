part of 'info_cubit.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}

final class GetInfoLoadingState extends InfoState {}

final class GetInfoSuccessState extends InfoState {}

final class GetInfoErrorState extends InfoState {
  final String message;

  GetInfoErrorState({required this.message});
}
