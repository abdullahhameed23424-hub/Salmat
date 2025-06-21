import 'package:salamat/modules/teachers/models/teacher.dart';

class TeachersResponse {
  Data data;
  TeachersResponse({required this.data});

  factory TeachersResponse.fromJson(Map<String, dynamic> json) =>
      TeachersResponse(data: Data.fromJson(json['data']));
}

class Data {
  List<Teacher> teachers;
  final int currentPage;
  Data({
    required this.teachers,
    required this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      teachers:
          List<Teacher>.from(json["data"].map((x) => Teacher.fromJson(x))),
      currentPage: json['current_page']);
}
