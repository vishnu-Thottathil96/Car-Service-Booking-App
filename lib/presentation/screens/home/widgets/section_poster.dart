import 'package:flutter/material.dart';
import 'package:motox/utils/constants/screen_size.dart';

Widget buildPosterSection(BuildContext context) {
  double width = MyScreenSize.screenWidth(context);
  double height = MyScreenSize.screenHeight(context);

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: SizedBox(
      width: width,
      height: height / 5,
      child: Image.asset(
        'assets/home_screen_images/poster2.png',
        fit: BoxFit.cover,
      ),
    ),
  );
}
