// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:salamat/modules/sections/models/section.dart';

class SectionsResponse {
  final Data data; 

  SectionsResponse({required this.data });

  factory SectionsResponse.fromJson(Map<String, dynamic> json) {
    return SectionsResponse( 
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
 