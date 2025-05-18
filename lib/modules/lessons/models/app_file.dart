class AppFile {
  final int id;
  final String url;
  final String name;
  final String image;
  
  AppFile(
      {required this.id,
      required this.url,
      required this.name,
      required this.image});

  factory AppFile.fromJson(Map<String, dynamic> json) => AppFile(
        id: json['id'],
        url: json['url'],
        name: json['name'],
        image: json['image'],
      );
}
