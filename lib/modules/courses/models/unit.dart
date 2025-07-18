// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:salamat/modules/courses/models/course.dart';
import 'package:salamat/utils/bool_converter.dart';

class Unit {
  final int id;
  final int parentId;
  final String name;
  final String? image;
  final String description;
  final String totalLessonsTime;
  final int lessonsCount;
  final Course? course;
  final bool isLockedByAdmin;
  final bool isLocked;
  final String lockReason;
  Unit({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.description,
    required this.totalLessonsTime,
    required this.lessonsCount,
    required this.course,
    required this.isLockedByAdmin,
    required this.isLocked,
    required this.lockReason,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        lockReason: json['lock_reason'] ?? "الوحدة مقفلة",

        isLocked: boolConverter(json['is_locked']),
        isLockedByAdmin: boolConverter(json['is_locked_by_admin']),
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
