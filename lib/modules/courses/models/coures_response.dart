import 'package:salamat/modules/courses/models/course.dart';
import 'package:salamat/modules/courses/models/unit.dart';

class CourseResponse {
  final CourseResponseData data;

  CourseResponse({required this.data});

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        data: CourseResponseData.fromJson(json["data"]),
      );
}

class CourseResponseData {
  final Original original;

  CourseResponseData({
    required this.original,
  });

  factory CourseResponseData.fromJson(Map<String, dynamic> json) =>
      CourseResponseData(
        original: Original.fromJson(json["original"]),
      );
}

class Original {
  final OriginalData data;
  final Course coures;

  Original({
    required this.data,
    required this.coures,
  });

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        data: OriginalData.fromJson(json["data"]),
        coures: Course.fromJson(json["parent_section"]),
      );
}

class OriginalData {
  final int currentPage;
  final List<Unit> data;

  OriginalData({
    required this.currentPage,
    required this.data,
  });

  factory OriginalData.fromJson(Map<String, dynamic> json) => OriginalData(
        currentPage: json["current_page"],
        data: List<Unit>.from(json["data"].map((x) => Unit.fromJson(x))),
      );
}
