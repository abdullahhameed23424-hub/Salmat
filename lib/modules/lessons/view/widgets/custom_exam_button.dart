import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/test/view/screens/test_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class DoExamButton extends StatefulWidget {
  const DoExamButton(
      {super.key,
      required this.onTap,
      this.color,
      required this.label,
      this.isPassed});
  final void Function() onTap;
  final Color? color;
  final String label;
  final bool? isPassed;
  @override
  State<DoExamButton> createState() => _DoExamButtonState();
}

class _DoExamButtonState extends State<DoExamButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(indent: 50.w, endIndent: 50.w, height: 40.h),
        Container(
          width: 1.sw,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: () {
              widget.onTap();
            },
            child: AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 100),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 7.5.h),
                decoration: BoxDecoration(
                  color: widget.color ?? Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.test, width: 50.w, height: 50.w),
                    SizedBox(width: 10.w),
                    Text(widget.label, style: titilliumBold),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
