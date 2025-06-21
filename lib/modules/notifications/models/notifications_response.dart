import 'package:salamat/modules/notifications/models/notification.dart';

class NotificationsResponse {
  final Notifications data;

  NotificationsResponse({
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
        data: Notifications.fromJson(json["data"]),
      );
}

class Notifications {
  final int currentPage;
  final List<AppNotification> notifications;

  Notifications({
    required this.currentPage,
    required this.notifications,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
      currentPage: json["current_page"],
      notifications: List<AppNotification>.from(
          json["data"].map((x) => AppNotification.fromJson(x))));
}
