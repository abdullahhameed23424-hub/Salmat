import 'package:salamat/utils/bool_converter.dart';

class AppNotification {
  final String title;
  final String? description;
  final int? state;
  final dynamic data;
  final bool hasRead;
  final String createdAt;

  AppNotification({
    required this.title,
    required this.description,
    required this.state,
    required this.data,
    required this.hasRead,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
          title: json["title"],
          description: json["description"],
          state: json["state"],
          data: json["data"],
          hasRead: boolConverter(json["has_read"]),
          createdAt: json["created_at"]);
}
