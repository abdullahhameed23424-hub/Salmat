// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
  laptop,
}

late double MAX_WIDTH;
late double MAX_Height;

Size getDeviceSize(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (width < 400) {
    MAX_WIDTH = 430;
    MAX_Height = 930;
    return Size(MAX_WIDTH, MAX_Height);
  } else if (width >= 400 && width < 800) {
    MAX_WIDTH = 500;
    MAX_Height = 700;

    return Size(MAX_WIDTH, MAX_Height);
  } else {
    MAX_WIDTH = 600;
    MAX_Height = 570;
    return Size(MAX_WIDTH, MAX_Height);
  }
}

DeviceType getDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (width < 600) {
    return DeviceType.mobile;
  } else if (width >= 600 && width < 1200) {
    return DeviceType.tablet;
  } else {
    return DeviceType.laptop;
  }
}
