import 'package:my_project_new/modules/points_record/models/points_response.dart';

class Points {
  final int id;
  final int points;
  final int pointsAfter;
  final String reason;
  final StudentName student;
  final DateTime createdAt;

  Points({
    required this.id,
    required this.points,
    required this.pointsAfter,
    required this.reason,
    required this.student,
    required this.createdAt,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        id: json["id"],
        points: json["points"],
        pointsAfter: json["points_after"],
        reason: json["reason"],
        student: StudentName.fromJson(json["student"]),
        createdAt: DateTime.parse(json["created_at"]),
      );
}
