// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:my_project_new/utils/bool_converter.dart';

class Course {
  final int id;
  final String name;
  final String decoration;
  final String image;
  final bool isFree;
  final String price; //before discount
  final String totalPrice; //  after discount
  final String discount;
  final String introVideo;

  Course(
      {required this.id,
      required this.name,
      required this.decoration,
      required this.image,
      required this.isFree,
      required this.price,
      required this.totalPrice,
      required this.discount,
      required this.introVideo});

  factory Course.fromJson(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      name: map['name'],
      decoration: map['decoration'] ?? "",
      image: map['image'] ?? "",
      introVideo: map['introVideo'] ?? "",
      isFree: boolConverter(map['is_free']),
      price: map['price'] ?? "0".toString(),
      totalPrice: map['totalPrice'] ?? "0".toString(),
      discount: map['discount'] ?? "0".toString(),
    );
  }
}
