import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/modules/info/cubit/info_cubit.dart';
import 'package:salamat/modules/info/view/widgets/connect_slide.dart';
import 'package:salamat/modules/info/view/widgets/contact_us_links1.dart';
import 'package:salamat/modules/info/view/widgets/contact_us_links2.dart';
import 'package:salamat/widgets/swaping_point.dart';

class ImagesSlider extends StatefulWidget {
  final InfoCubit infoCubit;
  const ImagesSlider({super.key, required this.infoCubit});

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _currentindex = 0;
  late final CarouselSliderController controller;

  @override
  void initState() {
    controller = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /// [SLIDER_IMAGES]
        SizedBox(
          height: 190.h,
          width: 1.sw,
          child: CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentindex = index;
                });
              },
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
            items: <Widget>[
              Image.asset(Images.aboutUsFirst, width: 1.sw),
              ConnectSlide(
                backgroundImage: Images.aboutUsLinks1,
                child: ContactUsLinks1(infoCubit: widget.infoCubit),
              ),
              ConnectSlide(
                backgroundImage: Images.aboutUsLinks2,
                child: ContactUsLinks2(infoCubit: widget.infoCubit),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),

        /// [SWAPPING_POINTS]
        SwappingPoints(
          length: 3,
          pageController: controller,
          currentIndex: _currentindex,
        ),
      ],
    );
  }
}
