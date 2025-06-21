import 'package:salamat/modules/courses/models/course.dart';

class MyCoursesResponse {
  final Data data;
  MyCoursesResponse(
    this.data,
  );
  factory MyCoursesResponse.fromJson(Map<String, dynamic> json) =>
      MyCoursesResponse(Data.fromJson(json['data']));
}

class Data {
  final int currentPage;
  final List<Course> courses;

  Data({required this.currentPage, required this.courses});
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json['current_page'],
        courses: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
      );
}
