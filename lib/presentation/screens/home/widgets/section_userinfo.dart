import 'package:flutter/material.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/reusable_functions/get_greeting.dart';

Widget buildUserInfoSection(BuildContext context, String userName) {
  double width = MyScreenSize.screenWidth(context);
  double height = MyScreenSize.screenHeight(context);
  String greeting = getGreeting();

  return SizedBox(
    width: width,
    height: height / 15,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$greeting $userName',
          style: TextStyles.subheadingBlack,
        ),
      ],
    ),
  );
}
