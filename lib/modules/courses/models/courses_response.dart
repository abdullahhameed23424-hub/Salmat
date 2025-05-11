import 'package:my_project_new/modules/courses/models/course.dart';

class CoursesResponse {
  final Data data;

  CoursesResponse({required this.data});
  factory CoursesResponse.fromJson(Map<String, dynamic> json) {
    return CoursesResponse(
        data: Data.fromJson(json['data']['original']['data']));
  }
}

class Data {
  final int currentPage;
  final List<Course> courses;

  Data({required this.currentPage, required this.courses});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        currentPage: json['current_page'],
        courses: List.from(json['data'])
            .map(
              (course) => Course.fromJson(course),
            )
            .toList());
  }
}
