import 'package:my_project_new/modules/courses/models/course.dart';
import 'package:my_project_new/utils/bool_converter.dart';

class Unit {
  final int id;
  final int parentId;
  final String name;
  final String? image;
  final String description;
  final String totalLessonsTime;
  final int lessonsCount;
  final Course? course;
  final bool isLocked;
  Unit({
    required this.id,
    required this.course,
    required this.parentId,
    required this.isLocked,
    required this.name,
    required this.image,
    required this.description,
    required this.totalLessonsTime,
    required this.lessonsCount,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        isLocked: boolConverter(json['is_locked']),
        id: json["id"],
        course: json["parent_section"] != null
            ? Course.fromJson(json["parent_section"])
            : null,
        parentId: json["parent_id"],
        name: json["name"],
        image: json["image"] ?? "",
        description: json["description"],
        totalLessonsTime: json["total_lessons_time"],
        lessonsCount: json["lessons_count"],
      );
}
