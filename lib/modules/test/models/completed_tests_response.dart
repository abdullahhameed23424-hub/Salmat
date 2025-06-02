import 'package:my_project_new/modules/test/models/test.dart';

class CompletedTestsResponse {
  final Data data;
  CompletedTestsResponse({required this.data});

  factory CompletedTestsResponse.fromJson(Map<String, dynamic> json) =>
      CompletedTestsResponse(data: Data.fromJson(json['data']));
}

class Data {
  final int currentPage;
  final List<Test> tests;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json['current_page'],
        tests: List<Test>.from(json["data"].map((x) => Test.fromJson(x))),
      );

  Data({required this.currentPage, required this.tests});
}
