import 'package:my_project_new/modules/subjects/models/subject.dart';

class SubjectsResponse {
  final Data data;
  final ExtraData exteraData;

  SubjectsResponse({
    required this.data,
    required this.exteraData,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectsResponse(
        exteraData: ExtraData.fromJson(json['extra_data']['info']),
        data: Data.fromJson(json['data']['original']['data']));
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
