import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/font_weights.dart';

class TextStyles {
  // Heading Text Style
  static TextStyle mainHeadingBlack = TextStyle(
    fontSize: 25,
    fontWeight: MyFontWeights.extraBold,
    color: blackColor,
  );

  // Subheading Text Style
  static TextStyle subheadingBlack = TextStyle(
    fontSize: 20,
    fontWeight: MyFontWeights.regular,
    color: blackColor,
  );
  static TextStyle subheadingGrey = TextStyle(
    fontSize: 20,
    fontWeight: MyFontWeights.regular,
    color: greyColor,
  );
  static TextStyle normalTextGrey = TextStyle(
    fontSize: 15,
    fontWeight: MyFontWeights.regular,
    color: greyColor,
  );
  static TextStyle normalTextWhite = TextStyle(
    fontSize: 15,
    fontWeight: MyFontWeights.regular,
    color: whiteColor,
  );
  static TextStyle normalTextBlack = TextStyle(
    fontSize: 15,
    fontWeight: MyFontWeights.regular,
    color: blackColor,
  );
  static TextStyle linkText = TextStyle(
    fontSize: 15,
    fontWeight: MyFontWeights.regular,
    color: gradientOrange,
  );
  static TextStyle buttonText = TextStyle(
    fontSize: 20,
    fontWeight: MyFontWeights.bold,
    color: whiteColor,
  );
}
