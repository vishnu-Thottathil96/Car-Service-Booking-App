import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildLegend() {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Slots Available',
            style: TextStyles.subheadingGrey,
          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: redColor,
          ),
          Text('Occupied'),
          CircleAvatar(
            radius: 8,
            backgroundColor: greenColor,
          ),
          Text('Free'),
        ],
      ),
    ),
  );
}
