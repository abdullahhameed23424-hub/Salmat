import 'package:my_project_new/utils/bool_converter.dart';

class Option {
  final int id;
  final String name;
  final bool isTrue;
  bool isChosen;

  Option({
    required this.id,
    required this.name,
    required this.isTrue,
    required this.isChosen,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json["id"],
      name: json["name"],
      isTrue: boolConverter(json["is_true"]),
      isChosen: boolConverter(json["is_chosen"]),
    );
  }
}
