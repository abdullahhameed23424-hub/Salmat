import 'package:flutter/material.dart';

class CornerBorderBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final Widget child;

  const CornerBorderBox({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.borderWidth,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          child,
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor, width: borderWidth),
                  right: BorderSide(color: borderColor, width: borderWidth),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor, width: borderWidth),
                  left: BorderSide(color: borderColor, width: borderWidth),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
