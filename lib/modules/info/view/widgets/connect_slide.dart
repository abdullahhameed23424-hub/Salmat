import 'package:flutter/material.dart';

class ConnectSlide extends StatelessWidget {
  const ConnectSlide({
    super.key,
    required this.child,
    required this.backgroundImage,
  });
  final Widget child;
  final String backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
