import 'package:my_project_new/modules/test/models/test.dart';

class CompletedTestsResponse {
  final CompletedTestsResponseData data;
  final ExtraData extraData;

  CompletedTestsResponse({
    required this.data,
    required this.extraData,
  });

  factory CompletedTestsResponse.fromJson(Map<String, dynamic> json) =>
      CompletedTestsResponse(
        data: CompletedTestsResponseData.fromJson(json["data"]),
        extraData: ExtraData.fromJson(json["extra_data"]),
      );
}


class CompletedTestsResponseData {
  final Original original;

  CompletedTestsResponseData({
    required this.original,
  });

  factory CompletedTestsResponseData.fromJson(Map<String, dynamic> json) =>
      CompletedTestsResponseData(
        original: Original.fromJson(json["original"]),
      );
}


class Original {
  final OriginalData data;

  Original({
    required this.data,
  });

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        data: OriginalData.fromJson(json["data"]),
      );
}


class OriginalData {
  final int? currentPage;
  final List<Test> data;

  OriginalData({
     this.currentPage,
    required this.data,
  });

  factory OriginalData.fromJson(Map<String, dynamic> json) => OriginalData(
        currentPage: json["current_page"],
        data: List<Test>.from(json["data"].map((x) => Test.fromJson(x))),
      );
}


class ExtraData {
  final AuthExams authExams;

  ExtraData({
    required this.authExams,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) => ExtraData(
        authExams: AuthExams.fromJson(json["auth_exams"]),
      );
}

class AuthExams {
  final String? image;

  AuthExams({
     this.image,
  });

  factory AuthExams.fromJson(Map<String, dynamic> json) => AuthExams(
        image: json["image1"],
      );
}
