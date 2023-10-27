import 'package:flutter/material.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildUserInfoSection(BuildContext context) {
  double width = MyScreenSize.screenWidth(context);
  double height = MyScreenSize.screenHeight(context);

  return SizedBox(
    width: width,
    height: height / 10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Good Morning User...',
          style: TextStyles.subheadingBlack,
        ),
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/home_screen_images/paul.png'),
        ),
      ],
    ),
  );
}
