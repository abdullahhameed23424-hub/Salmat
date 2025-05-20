import 'package:my_project_new/modules/lessons/models/app_file.dart';
import 'package:my_project_new/modules/test/models/test.dart';
import 'package:my_project_new/utils/bool_converter.dart';

class Lesson {
  final int lessonOrder;
  
  final int? examId;
  final int id;
  final int? nextLessonId;
  final String name;
  final bool isFree;
  final String description;
  final String videoUrl;
  final String videoFile;
  final String time;
  final String coverImage;
  final bool isOpen;
  final List<AppFile> files;
  final List<String> images;
  final Test? test;
  final int unitId;
  Lesson({
    required this.id,
    required this.examId,
    required this.images,
    required this.unitId,
    required this.lessonOrder,
     required this.name,
    required this.isFree,
    required this.description,
    required this.videoUrl,
    required this.videoFile,
    required this.time,
    required this.coverImage,
    required this.isOpen,
    required this.files,
    required this.nextLessonId,
    required this.test,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final bool? isOpen =
        json['is_open'] != null ? boolConverter(json["is_open"]) : null;

    final bool isFree = boolConverter(json["is_free"]);
    bool tempIsOpen;
    if (isOpen == null) {
      tempIsOpen = isFree;
    } else {
      tempIsOpen = isOpen;
    }

    return Lesson(
        test: json["exam"] != null ? Test.fromJson(json["exam"]) : null,
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        lessonOrder: json["lesson_order"],
        unitId: json['section_id'],
        examId: json['exam_id'],
       
        nextLessonId: json["next_lesson_id"],
        id: json["id"],
        name: json["name"],
        isFree: json["is_free"],
        description: json["description"],
        videoUrl: json["video_url"] ?? '',
        videoFile: json["video_file"] ?? "",
        time: json["time"],
        coverImage: json["cover_image"],
        files: json["files"] != null
            ? List<AppFile>.from(json["files"].map((x) => AppFile.fromJson(x)))
            : [],
        isOpen: tempIsOpen);
  }
}
