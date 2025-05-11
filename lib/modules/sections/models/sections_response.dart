// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_project_new/modules/sections/models/section.dart';

class SectionsResponse {
  final Data data;
  final ExtraData extraData;

  SectionsResponse({required this.data, required this.extraData});

  factory SectionsResponse.fromJson(Map<String, dynamic> json) {
    return SectionsResponse(
      extraData: ExtraData.fromJson(json['extra_data']['info']),
      data: Data.fromJson(json['data']['original']['data']),
    );
  }
}

class Data {
  final List<Section> sections;
  final int currentPage;

  Data({required this.sections, required this.currentPage});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      sections: json['data'] == null
          ? []
          : List<Section>.from(json['data'].map((x) => Section.fromJson(x))),
      currentPage: json['current_page']);
}

class ExtraData {
  final String headerText;

  ExtraData({
    required this.headerText,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      ExtraData(headerText: json['header']);
}
