class Book {
  final int id;
  final String name;
  final String image;
  final String description;
  final String file;
  Book(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.file});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      file: json['file'],
    );
  }
}
