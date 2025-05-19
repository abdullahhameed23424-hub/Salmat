import 'package:my_project_new/modules/courses/models/unit.dart';
import 'package:my_project_new/modules/lessons/models/app_file.dart';

class Lesson {
  final int lessonOrder;
  final int sectionId;
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

  final int unitId;
  Lesson({
    required this.id,
    required this.examId,
    required this.images,
    required this.unitId,
    required this.lessonOrder,
    required this.sectionId,
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
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        lessonOrder: json["lesson_order"],
        unitId: json['section_id'],
        examId: json['exam_id'],
        sectionId: json["section_id"],
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
        isOpen: json["is_open"],
      );
}
