import 'package:salamat/modules/test/models/result.dart';
import 'package:salamat/modules/test/models/test_response.dart';
import 'package:salamat/utils/bool_converter.dart';

class Test {
  final int id;
  final String description;
  final dynamic degree;
  final String name;
  final bool isSolving;
  final int minutes;
  final int passPercentage;
  final List<Question> questions;
  Result result;
  final int attemptCount;
  final bool isSubscribed;
  final dynamic remainingTime;
  final LatestStudentExam? latestStudentExam;
  final StudentExam? studentExam;
  Test(
      {required this.id,
      required this.description,
      required this.studentExam,
      required this.latestStudentExam,
      required this.degree,
      required this.isSolving,
      required this.minutes,
      required this.passPercentage,
      required this.name,
      required this.questions,
      required this.result,
      required this.attemptCount,
      required this.isSubscribed,
      required this.remainingTime});

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        studentExam: json['studentExam'] != null
            ? StudentExam.fromJson(json['studentExam'])
            : null,
        latestStudentExam: json['latest_student_exam'] != null
            ? LatestStudentExam.fromJson(json['latest_student_exam'])
            : null,
        name: json['name'] ?? "",
        remainingTime: json["remaining_time"],
        isSubscribed: boolConverter(json["is_subscribed"]),
        isSolving: boolConverter(json["is_solving"]),
        id: json["id"],
        description: json["description"] ?? "",
        degree: json["degree"],
        minutes: json["minutes"],
        passPercentage: json["pass_percentage"],
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : [],
        result: Result.fromJson(json["result"]),
        attemptCount: json["attempts_count"] ?? 0,
      );
}

class LatestStudentExam {
  final String degree;
  final String examDegree;
  final bool pass;

  LatestStudentExam(
      {required this.degree, required this.examDegree, required this.pass});
  factory LatestStudentExam.fromJson(Map<String, dynamic> json) =>
      LatestStudentExam(
          degree: stringOrZero(json['degree']),
          examDegree: stringOrZero(json['total_degree']),
          pass: boolConverter(json['pass']));
}
