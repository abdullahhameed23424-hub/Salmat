class Unit {
  final int id;
  final int parentId;
  final String name;
  final String image;
  final String description;
  final String totalLessonsTime;
  final int lessonsCount;

  Unit({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.description,
    required this.totalLessonsTime,
    required this.lessonsCount,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        totalLessonsTime: json["total_lessons_time"],
        lessonsCount: json["lessons_count"],
      );
}
