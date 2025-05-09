class Subject {
  final int id;
  final int courseCount;

  final String name;
  final String image;

  Subject(
      {required this.courseCount,
      required this.name,
      required this.image,
      required this.id});
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      courseCount: json['course_count'] ?? 0,
      id: json['id'],
      name: json['name'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
