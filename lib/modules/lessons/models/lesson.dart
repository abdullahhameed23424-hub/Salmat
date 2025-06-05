import 'package:my_project_new/modules/courses/models/unit.dart';
import 'package:my_project_new/modules/lessons/models/app_file.dart';
import 'package:my_project_new/modules/test/models/test.dart';
import 'package:my_project_new/modules/video/models/my_viedeo.dart';
import 'package:my_project_new/utils/bool_converter.dart';

import '../../../apis/urls.dart';

class Lesson {
  final int lessonOrder;
  final int? previousLessonId;
  final int? examId;
  int id;
  final int? nextLessonId;
  final int? nextUnitId;
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

  final List<MyVideo> myVideos;
  final String? audio;
  final Test? exam;
  final int unitId;
  final Unit? unit;
  Lesson({
    required this.id,
    required this.previousLessonId,
    required this.myVideos,
    required this.audio,
    required this.nextUnitId,
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
    required this.exam,
    required this.unit,
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

    int index = -1;
    List<MyVideo> streems = [];
    json['videos'].forEach((video){
      index++;
      streems.add(MyVideo(link: '${Urls.storageUrl}${video['url']}', value: index, quality: '${video['url']}p'));

    });

    // if (json["videos"] != null &&
    //     json["video_streams"].isNotEmpty &&
    //     json["video_streams"]["streams"] != null &&
    //     json["video_streams"]["streams"].isNotEmpty) {
    //   streems = List<MyVideo>.from(json["video_streams"]["streams"]
    //       .map((x) {
    //         index++;
    //         if (x["resolution"].startsWith("audio")) {
    //           return null;
    //         } else if (x["resolution"].startsWith("360") && x['itag'] == 134) {
    //           return MyVideo(
    //               link: x["url"], value: index, quality: x["resolution"]);
    //         } else {
    //           return null;
    //         }
    //       })
    //       .where((element) => element != null)
    //       .toList());
    //
    //   if (streems.isEmpty) {
    //     for (var x in json["video_streams"]["streams"]) {
    //       if (x["type"].startsWith("video")) {
    //         streems.add(MyVideo(
    //             link: x["url"], value: index, quality: x["resolution"]));
    //         break;
    //       }
    //     }
    //   }
    // }

    String audio = '';
    
    if (!json['video_file'].toString().startsWith('lessons/videos')) {
      audio = json["video_streams"] != null &&
              json["video_streams"].isNotEmpty &&
              json["video_streams"]["streams"] != null &&
              json["video_streams"]["streams"].isNotEmpty
          ? json["video_streams"]["streams"][0]["url"] ?? ""
          : "";
    }

    return Lesson(
      unit: json["parent_section"] != null
          ? Unit.fromJson(json["parent_section"])
          : null,
      exam: json["exam"] != null ? Test.fromJson(json["exam"]) : null,
      images: json["images"] != null
          ? List<String>.from(json["images"].map((x) => x))
          : [],
      lessonOrder: json["lesson_order"],
      unitId: json['section_id'],
      examId: json['exam_id'],
      nextUnitId: json["next_section_id"],
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
      previousLessonId: json["previous_lesson_id"],
      isOpen: tempIsOpen,
      myVideos: streems,
      audio: audio,
    );
  }
}
