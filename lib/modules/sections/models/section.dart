class Section {
  final int id;
  final String name;
  final String image;
  final String description;

  Section({
    required this.id, 
    required this.image,
    
    required this.name, required this.description});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(

        id: json['id'],
        name: json['name'] ?? "",
        image: json['image'] ?? "",
        description: json['description'] ?? "");
  }
}
