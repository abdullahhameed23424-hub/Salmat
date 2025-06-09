import 'package:my_project_new/modules/comments/models/comment_writer.dart';

class Comment {
  final int id;
  final String? body;
  final DateTime createdAt;
  final CommentWriter? user;

  Comment({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        user:
            json["user"] != null ? CommentWriter.fromJson(json["user"]) : null,
      );
}
