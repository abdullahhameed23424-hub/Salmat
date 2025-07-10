import 'package:salamat/modules/test/models/test_response.dart';
import 'package:salamat/utils/bool_converter.dart';

class Result {
  final bool?
      pass; //pass =true :success ,null : non skipped and not success , pass :false exam skipped
  String examDegree;
  final String examPassPercentage;
  String studentDegree;
  List<Question>? questions;
  Result({
    required this.pass,
    required this.studentDegree,
    required this.examDegree,
    required this.examPassPercentage,
    this.questions,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pass: json["pass"],
        studentDegree: stringOrZero(json["exam_student_degree"]),
        examDegree: stringOrZero(json["exam_degree"]),
        examPassPercentage: stringOrZero(json["exam_pass_percentage"]),
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : null,
      );
}
