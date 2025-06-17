import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/offers/models/offer.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    required this.offer,
    super.key,
  });
  final Offer offer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (offer.link != "") {
          try {
            EasyLauncher.url(
              url: offer.link,
              mode: Mode.platformDefault,
            );
          } catch (_) {
            debugPrint("unavailable link");
          }
        }
      },
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.PRIMARY.withOpacity(0.4),
                      offset: const Offset(0, 0.5),
                      blurRadius: 1.5,
                      spreadRadius: 1,
                    )
                  ],
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${Urls.storageUrl}${offer.image}"),
                      fit: BoxFit.cover),
                  color: AppColors.SECONDRY,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              alignment: AlignmentDirectional.bottomStart,
              width: 1.sw,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: (offer.description != "")
                  ? Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      offer.description,
                      style: titilliumBold.copyWith(
                        color: Colors.white,
                        shadows: textShadow,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
