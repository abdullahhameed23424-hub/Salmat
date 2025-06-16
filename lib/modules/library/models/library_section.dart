class LibrarySection {
  final int id;
  final String name;
  final String? image;
  final String description;
  LibrarySection({required this.id, required this.name,  this.image, required this.description});

  factory LibrarySection.fromJson(Map<String, dynamic> json) {
    return LibrarySection(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}
