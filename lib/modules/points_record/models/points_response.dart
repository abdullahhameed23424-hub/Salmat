import 'package:salamat/modules/points_record/models/points.dart';

class PointsResponse {
  final Data data;

  PointsResponse({required this.data});
  factory PointsResponse.fromJson(Map<String, dynamic> json) =>
      PointsResponse(data: Data.fromJson(json['data']));
}

class Data {
  final String totlaPoints;
  final List<Points> pointsList;

  Data({required this.totlaPoints, required this.pointsList});
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totlaPoints: json['points'].toString(),
        pointsList:
            List<Points>.from(json["history"].map((x) => Points.fromJson(x))),
      );
}

class StudentName {
  final int id;
  final String name;

  StudentName({
    required this.id,
    required this.name,
  });

  factory StudentName.fromJson(Map<String, dynamic> json) => StudentName(
        id: json["id"],
        name: json["name"],
      );
}
