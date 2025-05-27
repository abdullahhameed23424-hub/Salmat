import 'package:my_project_new/modules/courses/models/course.dart';

class Teacher {
  final int id;
  final String username;
  final String description;
  final String email;
  final String phoneNumber;
  final dynamic isHidden;
  final String job;
  final String logo;
  final String image;
  final List<Course> courses;

  Teacher({
    required this.id,
    required this.username,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.logo,
    required this.job,
    required this.isHidden,
    required this.image,
    required this.courses,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        logo: json["logo"] ?? "",
        id: json["id"],
        job: json["job"] ?? "",
        username: json["username"],
        description: json["description"] ?? "",
        email: json["email"],
        phoneNumber: json["phone_number"],
        isHidden: json["is_hidden"],
        image: json["image"],
        courses: json["courses"] != null
            ? List<Course>.from(json["courses"].map((x) => Course.fromJson(x)))
            : [],
      );
}
