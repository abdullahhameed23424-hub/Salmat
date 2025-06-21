import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/widgets/image_viewer.dart';
import 'package:salamat/utils/global_functions.dart';

class LessonImageCard extends StatelessWidget {
  const LessonImageCard({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 400),
      delay: Duration(milliseconds: 100 * (1 + Random().nextInt(7))),
      child: InkWell(
        onTap: () =>
            pushTo(context: context, toPage: ImageViewer(imageUrl: imagePath)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: boxShadow,
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Hero(
              tag: imagePath,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
