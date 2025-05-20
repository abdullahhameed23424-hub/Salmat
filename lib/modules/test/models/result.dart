import 'package:my_project_new/utils/bool_converter.dart';

class Result {
  final bool? pass;
  final String examDegree;
  final String examPassPercentage;
  final String examStudentDegree;
  final String studentDegree;

  Result({
    required this.pass,
    required this.studentDegree,
    required this.examDegree,
    required this.examPassPercentage,
    required this.examStudentDegree,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pass: json["pass"],
        studentDegree: stringOrZero(json["student_degree"]),
        examDegree: stringOrZero(json["exam_degree"]),
        examPassPercentage: stringOrZero(json["exam_pass_percentage"]),
        examStudentDegree: stringOrZero(json["exam_student_degree"]),
      );
}
