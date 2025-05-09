import 'package:my_project_new/modules/library/models/library_section.dart';

class LibraryResponse {
  final String? headerImage;
  final List<LibrarySection> sections;
  LibraryResponse({this.headerImage, required this.sections});
  factory LibraryResponse.fromJson(Map<String, dynamic> json) {
    return LibraryResponse(
      headerImage: json['headerImage'],
      sections: json['sections'] == null
          ? []
          : List<LibrarySection>.from(
              json['sections'].map((x) => LibrarySection.fromJson(x))),
    );
  }
}
