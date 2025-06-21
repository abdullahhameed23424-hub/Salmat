import 'package:salamat/modules/comments/models/comment.dart';
import 'package:salamat/modules/teachers/models/teacher.dart';
import 'package:salamat/utils/bool_converter.dart';

class Course {
  final int id;
  final String name;
  final String image;
  final bool isFree;
  final bool subscribed;
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
    required this.subscribed,
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



// Teachers
    if (json["teachers"] != null) {
      List<Teacher> teachers = List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x)));
      print("Teachers:");
      for (var teacher in teachers) {
        print(" - ${teacher.toString()}"); // أو طباعة بيانات محددة من كل معلم
      }
    } else {
      print("Teachers: []");
    }


// Total Lessons Time
    String totalTime = (json["total_lessons_time"] != null && json["total_lessons_time"] is String)
        ? getHoursFromTimeString(json["total_lessons_time"])
        : "0";
    print("Total Lessons Time: $totalTime");

// Comments
    if (json["comments"] != null) {
      List<Comment> comments = List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)));
      print("Comments:");
      for (var comment in comments) {
        print(" - ${comment.toString()}"); // أو طباعة تفاصيل التعليق
      }
    } else {
      print("Comments: []");
    }



    return Course(
      subscribed: boolConverter(json['subscribed']),
      id: json['id'],
      parentId: json["parent_id"],
      name: json['name'],
      requirements: json['requirements'] ?? "",
      image: json['image'] ?? "",
      introVideo: json['introVideo'] ?? "",
      isFree: boolConverter(json['is_free']),
      price: stringOrZero(json['price']),
      totalPrice: stringOrZero(json['price']),
      discount: stringOrZero(json['discount']),
      description: json['description'] ?? "",
      lessonsCount: json["lessons_count"] ?? 0,
      teachers: json["teachers"] != null
          ? List<Teacher>.from(json["teachers"].map((x) => Teacher.fromJson(x)))
          : [],
      totalLessonsTime: json["total_lessons_time"] != null &&
              json["total_lessons_time"] is String
          ? getHoursFromTimeString(json["total_lessons_time"])
          : "0",
      comments: json["comments"] != null
          ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)))
          : [],
    );
  }
}

String getHoursFromTimeString(dynamic dytime) {
  String time = dytime.toString();
  final parts = time.split(":").map(int.parse).toList();
  int hours = parts[0];

  int minutes = parts[1];
  int seconds = parts[2];
  time = (hours + (minutes / 60) + (seconds / 3600)).toStringAsFixed(1);
  final formattedTime = time.split('.');
  if (formattedTime[1] == "0") {
    return formattedTime[0];
  } else {
    return time;
  }
}
