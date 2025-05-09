import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';

class Nodata extends StatefulWidget {
  const Nodata({
    super.key,
  });

  @override
  State<Nodata> createState() => _NodataState();
}

class _NodataState extends State<Nodata> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _animation = Tween<double>(begin: 0.1, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 120.h),
          AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Image.asset(Images.noData,
                    height: 160.h + (7.h * _animation.value));
              }),
          const SizedBox(
            width: double.infinity,
          ),
          Text(translate('no_data', context), style: titilliumBold)
        ],
      ),
    );
  }
}
