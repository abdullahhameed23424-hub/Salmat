import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/widgets/app_shimmer.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.boxFit,
    this.borderRadius,
  });

  final String image;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: '${Urls.storageUrl}$image',
        fit: boxFit,
        imageBuilder: (context, imageProvider) {
           
          return Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(image: imageProvider, fit: boxFit),
            ),
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return AppShimmer(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100, borderRadius: borderRadius),
            ),
          );
        },
        errorListener: (value) {
          print("imageerror ${value.toString()}");
        },
        errorWidget: (context, url, error) {
          print("imageerror $error  url $url ");
          return const Icon(
            Icons.error_outline,
            color: AppColors.PRIMARY,
          );
        },
      ),
    );
  }
}
