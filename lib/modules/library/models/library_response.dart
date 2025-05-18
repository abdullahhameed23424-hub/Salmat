import 'package:my_project_new/modules/library/models/library_section.dart';

class LibrarySectionsResponse {
  final LibrarySectionsResponseData data;
  final ExtraData extraData;
  LibrarySectionsResponse( {
    required this.data,
    required this.extraData
  });

  factory LibrarySectionsResponse.fromJson(Map<String, dynamic> json) =>
      LibrarySectionsResponse(
         
         extraData: ExtraData.fromJson(json['extra_data']),
        data: LibrarySectionsResponseData.fromJson(json["data"]),
      );
}

class LibrarySectionsResponseData {
  final Original original;

  LibrarySectionsResponseData({
    required this.original,
  });

  factory LibrarySectionsResponseData.fromJson(Map<String, dynamic> json) =>
      LibrarySectionsResponseData(
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
  final int currentPage;
  final List<LibrarySection> data;

  OriginalData({required this.currentPage, required this.data});

  factory OriginalData.fromJson(Map<String, dynamic> json) => OriginalData(
        currentPage: json["current_page"],
        data: List<LibrarySection>.from(
            json["data"].map((x) => LibrarySection.fromJson(x))),
      );
}

class ExtraData {
  final String image;
  final String description;

  ExtraData({required this.image, required this.description});
  factory ExtraData.fromJson(Map<String, dynamic> json) => ExtraData(
      image: json['info']['image'] ?? "",
      description: json['info']['description'] ?? "");
}
