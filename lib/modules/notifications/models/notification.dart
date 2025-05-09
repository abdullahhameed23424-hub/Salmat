class AppNotification {
  final String title;
  final String? body; 
  final int state; 
  final dynamic data;
  final bool clickable;
  final DateTime createdAt;

  AppNotification({
    required this.title,
    required this.body, 
    required this.state, 
    required this.data,
    required this.clickable,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        title: json["title"],
        body: json["body"], 
        state: json["state"] ?? 0, 
        data: json["data"],
        clickable: json["clickable"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
