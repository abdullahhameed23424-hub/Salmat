import 'package:my_project_new/modules/comments/models/comment.dart';
import 'package:my_project_new/modules/library/models/library_info.dart';
import 'package:my_project_new/modules/offers/models/offer.dart';
import 'package:my_project_new/modules/sections/models/section.dart';

class HomeResponse {
  final List<Offer> offers;
  final List<Section> sections;
  final List<Comment> latestCourses;
  final LibraryInfo? libraryInfo;

  HomeResponse(
      {required this.offers,
      required this.sections,
      required this.libraryInfo,
      required this.latestCourses});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      libraryInfo: json['library'] == null
          ? LibraryInfo(decoration: "", image: '')
          : LibraryInfo.fromJson(json['library']),
      offers: json['offers'] == null
          ? [ ] : List<Offer>.from(json['offers'].map((x) => Offer.fromJson(x))),
      sections: json['sections'] == null
          ? [ ] : List<Section>.from(
              json['sections'].map((x) => Section.fromJson(x))),
      latestCourses: json['latestCourses'] == null
          ? [ ] : List<Comment>.from(
              json['latestCourses'].map((x) => Comment.fromJson(x))),
    );
  }
}
