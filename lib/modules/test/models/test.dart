import 'package:my_project_new/modules/test/models/result.dart';
import 'package:my_project_new/modules/test/models/test_response.dart';
import 'package:my_project_new/utils/bool_converter.dart';

class Test {
  final int id;
  final int lessonId;
  final int unitId;
  final String description;
  final int degree;
  final String name;
  final bool isSolving;
  final int minutes;
  final int passPercentage;
  final int questionsCount;
  final List<Question> questions;
  final Result result;
  final StudentExam studentExam;
  final int attemptCount;
  final bool isSubscribed;
  final dynamic remainingTime;
  Test(
      {required this.id,
      required this.lessonId,
      required this.unitId,
      required this.description,
      required this.degree,
      required this.name,
      required this.isSolving,
      required this.minutes,
      required this.passPercentage,
      required this.questionsCount,
      required this.questions,
      required this.result,
      required this.studentExam,
      required this.attemptCount,
      required this.isSubscribed,
      required this.remainingTime});

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        lessonId: json["lesson_id"] ?? 0,
        unitId: json["unit_id"] ?? 0,
        remainingTime: json["remaining_time"],
        isSubscribed: boolConverter(json["is_subscribed"]),
        isSolving: boolConverter(json["is_solving"]),
        id: json["id"],
        description: json["description"] ?? "",
        degree: json["degree"],
        name: json["name"],
        minutes: json["minutes"],
        passPercentage: json["pass_percentage"],
        questionsCount: json["questions_count"],
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : [],
        result: Result.fromJson(json["result"]),
        studentExam: StudentExam.fromJson(json["studentExam"]),
        attemptCount: json["attempts_count"] ?? 0,
      );
}
