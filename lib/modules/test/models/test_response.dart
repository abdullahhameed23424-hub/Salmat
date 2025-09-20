import 'package:salamat/modules/test/models/option.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/utils/bool_converter.dart';

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
  final String? note;

  final List<Option> options;
  final bool chosenAndTrue;

  Question({
    required this.id,
    required this.video,
    required this.text,
    required this.degree,
    required this.image,
    required this.note,
    required this.options,
    required this.chosenAndTrue,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        note: json["note"] ?? "",
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
  final bool skipped;
  final int attemptCount;
  StudentExam({
    required this.skipped,
    required this.attemptCount,
  });

  factory StudentExam.fromJson(Map<String, dynamic> json) => StudentExam(
      skipped: boolConverter(
        json['skipped'],
      ),
      attemptCount: json['attempts_count'] ?? 0);
}
