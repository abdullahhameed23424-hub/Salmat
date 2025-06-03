class PointsResponse {
  final Data data;

  PointsResponse({required this.data});
  factory PointsResponse.fromJson(Map<String, dynamic> json) =>
      PointsResponse(data: Data.fromJson(json['data']));
}

class Data {
  final String points;
  final List pointsDetails;

  Data({required this.points, required this.pointsDetails});
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(points: json['points'], pointsDetails: json['history']);
}
