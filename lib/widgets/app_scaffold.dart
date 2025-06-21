import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/dimensions.dart';

import 'package:salamat/widgets/custom_app_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.fontSize = 14,
    this.backgroundColor,
    this.appBarBorderRadius, this.floatingActionButton,
  });
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final double fontSize;
  final Color? backgroundColor;
  final BorderRadiusGeometry? appBarBorderRadius;
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: floatingActionButton ,
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, Dimensions.APPBAR_HEIGHT),
          child: CustomAppBar(
              title: title, appBarBorderRadius: appBarBorderRadius),
        ),
        body: body);
  }
}
