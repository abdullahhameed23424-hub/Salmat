part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitialState extends NotificationsState {}

final class GetNotificationsLoadingState extends NotificationsState {}

final class GetNotificationsSuccessState extends NotificationsState {}

final class GetNotificationsErrorState extends NotificationsState {
  GetNotificationsErrorState({required this.message});
  final String message;
}

final class MakeUnreadZeroState extends NotificationsState {}
