import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';

class NoData extends StatefulWidget {
  const NoData({
    super.key,
    this.title,
  });
  final String? title;
  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> with SingleTickerProviderStateMixin {
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
          Text(widget.title ?? translate('no_data', context),
              style: titilliumBold)
        ],
      ),
    );
  }
}
