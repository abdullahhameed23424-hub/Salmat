import 'package:my_project_new/modules/lessons/models/lesson.dart';

class LessonsResponse {
  final Data data;

  LessonsResponse({
    required this.data,
  });
  factory LessonsResponse.fromJson(Map<String, dynamic> json) =>
      LessonsResponse(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final int currentPage;
  final List<Lesson> data;

  Data({
    required this.currentPage,
    required this.data,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
      currentPage: json["current_page"],
      data: List<Lesson>.from(
          json["data"].map((lesson) => Lesson.fromJson(lesson,null))));
}
