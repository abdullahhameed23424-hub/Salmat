import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/widgets/cached_image.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.SECONDRY,
      ),
      body: InteractiveViewer(
        child: Center(
            child: Hero(
          tag: imageUrl,
          child: CachedImage(
            image: imageUrl,
            boxFit: BoxFit.contain,
          ),
        )),
      ),
    );
  }
}
