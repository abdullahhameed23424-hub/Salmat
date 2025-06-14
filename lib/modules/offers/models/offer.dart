// ignore_for_file: public_member_api_docs, sort_constructors_first
class Offer {
  final String image;
  final String description;
  final String link;
  Offer({
    required this.image,
    required this.description,
    required this.link,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      image: json['image'] ?? "",
      description: json['description'] ?? "",
      link: json['link'] ?? "",
    );
  }
}
