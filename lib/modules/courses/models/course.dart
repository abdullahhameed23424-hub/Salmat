import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/teachers/models/teacher.dart';
import 'package:my_project_new/utils/bool_converter.dart';

class Course {
  final int id;
  final String name;
  final String image;
  final bool isFree;
  final String price; //before discount
  final String totalPrice; //  after discount
  final String discount;
  final String introVideo;
  final int? parentId;
  final String description;
  final String requirements;
  final String totalLessonsTime;
  final int lessonsCount;
  final List<Teacher> teachers;
  final List<Comment> comments;

  Course({
    required this.id,
    required this.name,
    required this.image,
    required this.isFree,
    required this.price,
    required this.totalPrice,
    required this.discount,
    required this.introVideo,
    required this.description,
    required this.requirements,
    required this.lessonsCount,
    required this.parentId,
    required this.teachers,
    required this.totalLessonsTime,
    required this.comments,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      parentId: json["parent_id"],
      name: json['name'],
      requirements: json['requirements'] ?? "",
      image: json['image'] ?? "",
      introVideo: json['introVideo'] ?? "",
      isFree: boolConverter(json['is_free']),
      price: stringOrZero(json['price']),
      totalPrice: stringOrZero(json['totalPrice']),
      discount: stringOrZero(json['discount']),
      description: json['description'] ?? "",
      lessonsCount: json["lessons_count"],
      teachers: json["teachers"] != null
          ? List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x)))
          : [],
      totalLessonsTime: getHoursFromTimeString(json["total_lessons_time"]),
      comments: json["comments"] != null
          ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)))
          : [],
    );
  }
}

String getHoursFromTimeString(String time) {
  final parts = time.split(":").map(int.parse).toList();
  int hours = parts[0];
  int minutes = parts[1];
  int seconds = parts[2];

  return (hours + (minutes / 60) + (seconds / 3600)).toStringAsFixed(1);
}
