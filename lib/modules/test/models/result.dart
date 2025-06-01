import 'package:my_project_new/modules/test/models/test_response.dart';
import 'package:my_project_new/utils/bool_converter.dart';

class Result {
  final bool?
      pass; //pass =true :success ,null : non skipped and not success , pass :false exam skipped
  final String examDegree;
  final String examPassPercentage;
  final String examStudentDegree;
  final String studentDegree;
  List<Question>? questions;
  Result({
    required this.pass,
    required this.studentDegree,
    required this.examDegree,
    required this.examPassPercentage,
    required this.examStudentDegree,
    this.questions,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pass: json["pass"],
        studentDegree: stringOrZero(json["student_degree"]),
        examDegree: stringOrZero(json["exam_degree"]),
        examPassPercentage: stringOrZero(json["pass_percentage"]),
        examStudentDegree: stringOrZero(json["student_percentage"]),
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : null,
      );
}
