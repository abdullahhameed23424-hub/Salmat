import 'package:my_project_new/modules/test/models/option.dart';
import 'package:my_project_new/modules/test/models/test.dart';

class TestResponse {
  final Test data;

  TestResponse({
    required this.data,
  });

  factory TestResponse.fromJson(Map<String, dynamic> json) => TestResponse(
        data: Test.fromJson(json["data"]),
      );
}

class Question {
  final int id;
 
  final String text;
  final int degree;
  final String video;
  final String image;

  final List<Option> options;
  final bool chosenAndTrue;

  Question({
    required this.id, 
    required this.text,
    required this.degree,
    required this.video,
    required this.image,
    required this.options,
    required this.chosenAndTrue,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
      
        text: json["text"],
        degree: json["degree"],
        video: json["video"] ?? "",
        image: json["image"] ?? "",
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        chosenAndTrue: json["chosen_and_true"],
      );
}

class StudentExam {
  final dynamic id;
  final dynamic studentId;
  final dynamic examId;
  final dynamic startDate;
  final dynamic endDate;
  final dynamic degree;
  final dynamic totalDegree;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic examDegree;
  final dynamic examPassPercentage;

  StudentExam({
    required this.id,
    required this.studentId,
    required this.examId,
    required this.startDate,
    required this.endDate,
    required this.degree,
    required this.totalDegree,
    required this.createdAt,
    required this.updatedAt,
    required this.examDegree,
    required this.examPassPercentage,
  });

  factory StudentExam.fromJson(Map<String, dynamic> json) => StudentExam(
        id: json["id"],
        studentId: json["student_id"],
        examId: json["exam_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        degree: json["degree"],
        totalDegree: json["total_degree"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        examDegree: json["exam_degree"],
        examPassPercentage: json["exam_pass_percentage"],
      );
}
