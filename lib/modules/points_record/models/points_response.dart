import 'package:salamat/modules/points_record/models/points.dart';

class PointsResponse {
  final ResponseData data;
  final int code;
  final String serverTime;
  final InfoPoints? infoPoints;

  PointsResponse({
    required this.data,
    required this.code,
    required this.serverTime,
     this.infoPoints,
  });

  factory PointsResponse.fromJson(Map<String, dynamic> json) => PointsResponse(
        data: ResponseData.fromJson(json['data']),
        code: json['code'],
        serverTime: json['server_time'],
        infoPoints: InfoPoints(text:
          '''
          آلية جميع النقاط في منصة سلامات التعليمية

عزيزي الطالب يمكنك الحصول على النقاط من تقديمك للاختبارات المؤتمتة داخل المنصة وفق الشروط التالية:

أن تحصل على 75٪ على الأقل من علامة الاختبار.

أن تُرسل حل الاختبار كاملاً قبل انتهاء وقت الاختبار المذكور بأعلى كل اختبار.

أن تكون المحاولة الأولى لتقديم الاختبار، بعد المحاولة الأولى لإرسال الاختبار لن تُضاف النقاط لمجموع نقاطك.

يتم الاعتماد على مجموع النقاط لتحديد مستوى الطالب وترتيبه.\n

منصة سلامات التعليمية
          '''
        ),
      );
}

class ResponseData {
  final Map<String, dynamic> headers;
  final OriginalData original;
  final dynamic exception;

  ResponseData({
    required this.headers,
    required this.original,
    this.exception,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        headers: json['headers'] ?? {},
        original: OriginalData.fromJson(json['original']),
        exception: json['exception'],
      );
}

class OriginalData {
  final Data data;
  final int code;
  final String serverTime;

  OriginalData({
    required this.data,
    required this.code,
    required this.serverTime,
  });

  factory OriginalData.fromJson(Map<String, dynamic> json) => OriginalData(
        data: Data.fromJson(json['data']),
        code: json['code'],
        serverTime: json['server_time'],
      );
}

class Data {
  final int points;
  final List<Points> history;

  Data({required this.points, required this.history});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        points: json['points'] ?? 0,
        history: json['history'] != null
            ? List<Points>.from(json["history"].map((x) => Points.fromJson(x)))
            : [],
      );
}

class InfoPoints {
  final String text;

  InfoPoints({required this.text});

  factory InfoPoints.fromJson(Map<String, dynamic> json) => InfoPoints(
        text: json['text'] ?? '',
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
