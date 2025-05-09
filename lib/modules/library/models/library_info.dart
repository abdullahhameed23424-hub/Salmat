class LibraryInfo {
  final String decoration;
  final String image;

  LibraryInfo({required this.decoration, required this.image});

  factory LibraryInfo.fromJson(Map<String, dynamic> json) {
    return LibraryInfo(
      decoration: json['decoration'],
      image: json['image'],
    );
  }
}
