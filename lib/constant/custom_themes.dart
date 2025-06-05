// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_project_new/constant/dimensions.dart';

const String FONTF_FAMILY = "NotoKufiArabic";
final TextStyle titilliumRegular = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_SMALL,
);
final TextStyle regularSemiBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_SMALL,
);

final TextStyle titleRegular = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);
final TextStyle titleHeader = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.FONT_SIZE_LARGE,
);
final TextStyle titilliumSemiBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);

final TextStyle titilliumBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  color: Colors.black,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);
final TextStyle titilliumItalic = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontStyle: FontStyle.italic,
);

final TextStyle robotoRegular = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

final TextStyle robotoBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);

final TextStyle largeBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_LARGE,
  fontWeight: FontWeight.w700,
);
final TextStyle extraLargeBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
  fontWeight: FontWeight.w700,
);
