import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/modules/info/view/widgets/corner_border_box.dart';

class PlatformFeatureCard extends StatelessWidget {
  final String number;
  final String text;
  final String? image;

  const PlatformFeatureCard({
    super.key,
    required this.number,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return CornerBorderBox(
        width: 200,
        height: 200,
        borderColor: Colors.black,
        borderWidth: 3,
        radius: 40,
        child: Container(
          height: constrains.maxHeight,
          padding: EdgeInsets.all(6.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: (image != null)
                      ? Image.asset(image!, width: 25.w)
                      : Text(
                          number,
                          style: titleHeader.copyWith(
                              color: AppColors.PRIMARY, fontFamily: "bagel"),
                        )),
              Text(
                text,
                maxLines: 6,
                style: titilliumRegular,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
