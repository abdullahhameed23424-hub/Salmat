import 'package:flutter/material.dart';

class TeacherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double y = size.height;

    double x = size.width;

    Path path = Path();

    path.lineTo(x, 0);
    path.lineTo(x, y);
    path.lineTo(0, y / 4.5);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
