import 'package:flutter/material.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildTopBar(BuildContext context) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      Text(
        'Select date and time',
        style: TextStyles.mainHeadingBlack,
      ),
    ],
  );
}
