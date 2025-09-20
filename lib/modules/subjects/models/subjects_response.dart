// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:salamat/modules/sections/models/section.dart';
import 'package:salamat/modules/subjects/models/subject.dart';

class SubjectsResponse {
  final Original original;
  final ExtraData exteraData;

  SubjectsResponse({
    required this.original,
    required this.exteraData,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectsResponse(
        exteraData: ExtraData.fromJson(json['extra_data']['info']),
        original: Original.fromJson(json['data']['original']));
  }
}

class Original {
  final Data data;
  final Section section;
  Original({
    required this.data,
    required this.section,
  });

  factory Original.fromJson(Map<String, dynamic> json) {
    return Original(
        data: Data.fromJson(json['data']),
        section: Section.fromJson(json['parent_section']));
  }
}

class Data {
  final int currentPage;
  final List<Subject> seubjects;
  final String image;
  Data(
      {required this.image,
      required this.currentPage,
      required this.seubjects});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      image: json['image'] ?? "",
      currentPage: json['current_page'],
      seubjects: json['data'] == null
          ? []
          : List<Subject>.from(json['data'].map((x) => Subject.fromJson(x))),
    );
  }
}

class ExtraData {
  final String headerText;
  final String image;
  ExtraData({
    required this.headerText,
    required this.image,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      ExtraData(headerText: json['header'], image: json['image1']);
}
