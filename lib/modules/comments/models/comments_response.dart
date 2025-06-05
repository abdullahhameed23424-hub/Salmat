import 'package:my_project_new/modules/comments/models/comment.dart';

class CommentsResponse {
  final List<Comment> data;

  CommentsResponse({
    required this.data,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      CommentsResponse(
        data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );
}
