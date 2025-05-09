class Offer {
  final String image;

  Offer({required this.image});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      image: json['image'],
    );
  }
}
