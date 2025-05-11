import 'package:my_project_new/modules/subjects/models/subject.dart';

class SubjectsResponse {
  final _Data data;

  SubjectsResponse({required this.data});

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectsResponse(data: _Data.fromJson(json['data']));
  }
}

class _Data {
  final int currentPage;
  final List<Subject> seubjects;
  final String image;

  _Data(
      {required this.image,
      required this.currentPage,
      required this.seubjects});
  factory _Data.fromJson(Map<String, dynamic> json) {
    return _Data(
      image: json['image'] ?? "",
      currentPage: json['current_page'],
      seubjects: json['data'] == null
          ? []
          : List<Subject>.from(json['data'].map((x) => Subject.fromJson(x))),
    );
  }
}
