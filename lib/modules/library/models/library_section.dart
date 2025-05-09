class LibrarySection {
  final int id;
  final String name;
  final String image;

  LibrarySection({required this.id, required this.name, required this.image});

  factory LibrarySection.fromJson(Map<String, dynamic> json) {
    return LibrarySection(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
