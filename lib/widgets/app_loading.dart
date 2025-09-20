import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: StretchedDots(color: AppColors.PRIMARY, size: 60.sp));
  }
}

// this code  taken from package to make it more customize

class StretchedDots extends StatefulWidget {
  final double size;
  final Color color;
  final double innerHeight;
  final double dotWidth;

  const StretchedDots({
    super.key,
    required this.size,
    required this.color,
  })  : innerHeight = size / 1.3,
        dotWidth = size / 8;

  @override
  State<StretchedDots> createState() => _StretchedDotsState();
}

class _StretchedDotsState extends State<StretchedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Cubic firstCurve = Curves.easeInCubic;
  final Cubic secondCurve = Curves.easeOutCubic;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double innerHeight = widget.innerHeight;
    final double dotWidth = widget.dotWidth;
    final Color color = widget.color;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: SizedBox(
          height: innerHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.0,
                      0.15,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.15,
                      0.30,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.5,
                      0.65,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.65,
                      0.80,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.05,
                      0.20,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.20,
                      0.35,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.55,
                      0.70,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.70,
                      0.85,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.10,
                      0.25,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.25,
                      0.40,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.60,
                      0.75,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.75,
                      0.90,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.15,
                      0.30,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.30,
                      0.45,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.65,
                      0.80,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.80,
                      0.95,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BuildDot extends StatelessWidget {
  final AnimationController controller;
  final double dotWidth;
  final Color color;
  final double innerHeight;

  final Interval firstInterval;
  final Interval secondInterval;
  final Interval thirdInterval;
  final Interval forthInterval;

  const BuildDot({
    super.key,
    required this.controller,
    required this.dotWidth,
    required this.color,
    required this.innerHeight,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.forthInterval,
  });

  @override
  Widget build(BuildContext context) {
    final double offset = innerHeight / 4.85;
    final double height = innerHeight / 1.7;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        controller.value < firstInterval.end
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: controller.eval(
                    Tween<Offset>(begin: Offset.zero, end: Offset(0, -offset)),
                    curve: firstInterval,
                  ),
                  child: RoundedRectangle.vertical(
                    width: dotWidth,
                    // height: height,
                    color: color,
                    height: controller.eval(
                      Tween<double>(begin: dotWidth, end: height),
                      curve: firstInterval,
                    ),
                  ),
                ),
              )
            : Visibility(
                visible: controller.value <= secondInterval.end,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: controller.eval(
                      Tween<Offset>(begin: Offset(0, offset), end: Offset.zero),
                      curve: secondInterval,
                    ),
                    child: RoundedRectangle.vertical(
                      width: dotWidth,
                      color: color,
                      height: controller.eval(
                        Tween<double>(begin: height, end: dotWidth),
                        curve: secondInterval,
                      ),
                    ),
                  ),
                ),
              ),
        controller.value < thirdInterval.end
            ? Visibility(
                visible: controller.value >= secondInterval.end,
                replacement: SizedBox(
                  width: dotWidth,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: controller.eval(
                      Tween<Offset>(begin: Offset.zero, end: Offset(0, offset)),
                      curve: thirdInterval,
                    ),
                    child: RoundedRectangle.vertical(
                      width: dotWidth,
                      height: controller.eval(
                        Tween<double>(begin: dotWidth, end: height),
                        curve: thirdInterval,
                      ),
                      color: color,
                    ),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: controller.eval(
                    Tween<Offset>(begin: Offset(0, -offset), end: Offset.zero),
                    curve: forthInterval,
                  ),
                  child: RoundedRectangle.vertical(
                    width: dotWidth,
                    height: controller.eval(
                      Tween<double>(begin: height, end: dotWidth),
                      curve: forthInterval,
                    ),
                    color: color,
                  ),
                ),
              ),
      ],
    );
  }
}

class RoundedRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final bool vertical;
  const RoundedRectangle.vertical({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  }) : vertical = true;

  const RoundedRectangle.horizontal({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  }) : vertical = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          vertical ? width : height,
        ),
      ),
    );
  }
}

extension LoadingAnimationControllerX on AnimationController {
  T eval<T>(Tween<T> tween, {Curve curve = Curves.linear}) =>
      tween.transform(curve.transform(value));

  double evalDouble({
    double from = 0,
    double to = 1,
    double begin = 0,
    double end = 1,
    Curve curve = Curves.linear,
  }) {
    return eval(
      Tween<double>(begin: from, end: to),
      curve: Interval(begin, end, curve: curve),
    );
  }
}
