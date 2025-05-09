class Comment {
  final int id;
  final int likesCount;
  final String writer;
  final String text;
  Comment(
      {required this.id,
      required this.likesCount,
      required this.writer,
      required this.text});
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        likesCount: json['likes'],
        id: json['id'],
        writer: json['writer'],
        text: json['text'],
      );
}
