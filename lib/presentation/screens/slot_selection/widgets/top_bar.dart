import 'package:flutter/material.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildTopBar() {
  return Row(
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_back_ios),
      ),
      Text(
        'Select date and time',
        style: TextStyles.mainHeadingBlack,
      ),
    ],
  );
}
