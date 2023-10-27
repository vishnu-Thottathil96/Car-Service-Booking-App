import 'package:flutter/material.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

Widget buildBookingCard(int index, double height) {
  return Material(
    elevation: 5,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      height: height / 5,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingDates[index],
              style: TextStyles.subheadingBlack,
            ),
            vertical20,
            Text('Vehicle: Bmw m5'),
            vertical20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: statusColor[index],
                ),
                SizedBox(width: 20),
                Text(status[index]),
              ],
            ),
            vertical20,
            Text('Service: ${serviceTypes[index]}'),
          ],
        ),
      ),
    ),
  );
}
