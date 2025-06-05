import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/offers/models/offer.dart';
import 'package:my_project_new/modules/sections/models/section.dart';

class HomeResponse {
  final Data data;

  HomeResponse({required this.data});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(data: Data.fromJson(json['data']));
  }
}

class Data {
  final List<Offer> offers;
  final Sections sections;
  final LibraryInfo? libraryInfo;
  final List<Comment> platformComments;
  Data({
    required this.offers,
    required this.sections,
    required this.libraryInfo,
    required this.platformComments,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      offers: json['offers']['data'] == null
          ? [ ] : List<Offer>.from(
              json['offers']['data'].map((x) => Offer.fromJson(x))),
      sections: Sections.fromJson(json['sections']),
      libraryInfo: json['library'] == null
          ? null
          : LibraryInfo.fromJson(json['library']),
      platformComments: json['platform_comments'] == null
          ? [ ] : List<Comment>.from(
              json['platform_comments'].map((x) => Comment.fromJson(x))),
    );
  }
}

class Sections {
  List<Section> sections;

  Sections({required this.sections});

  factory Sections.fromJson(Map<String, dynamic> json) {
    return Sections(
        sections:
            List<Section>.from(json['data'].map((x) => Section.fromJson(x))));
  }
}

class LibraryInfo {
  final String image;

  LibraryInfo({required this.image});

  factory LibraryInfo.fromJson(Map<String, dynamic> json) {
    return LibraryInfo(
      image: json['image'],
    );
  }
}
