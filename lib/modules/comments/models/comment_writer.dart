class CommentWriter {
  final int id;
  final String username;
  final String? image;

  CommentWriter({
    required this.id,
    required this.username,
    required this.image,
  });

  factory CommentWriter.fromJson(Map<String, dynamic>? json) => CommentWriter(
        id: json?["id"] ?? -1,
        username: json?["username"] ?? '',
        image: json?["image"]??'',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "image": image,
      };
}
