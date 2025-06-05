class AppFile {
  final int id;
  final String url;
  final String name;

  AppFile({
    required this.id,
    required this.url,
    required this.name,
  });

  factory AppFile.fromJson(Map<String, dynamic> json) => AppFile(
        id: json['id'],
        url: json['url'],
        name: json['name'],
      );
}
