import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/service_description/service_description.dart';
import 'package:motox/presentation/screens/slot_selection/screen_slot.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

Widget buildServiceTypesSection(BuildContext context) {
  double width = MyScreenSize.screenWidth(context);
  double height = MyScreenSize.screenHeight(context);

  return Column(
    children: [
      Text(
        'Quality Services for Every Need',
        style: TextStyles.subheadingBlack,
      ),
      vertical10,
      SizedBox(
        width: width,
        height: height / 1.5,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: 25,
          ),
          itemBuilder: (context, index) {
            return buildServiceCard(index, context);
          },
          itemCount: 6,
        ),
      ),
    ],
  );
}

Widget buildServiceCard(int index, BuildContext context) {
  return Card(
    elevation: 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SlotSelectionPage(
                  serviceType: serviceTypes[index],
                );
              },
            ));
          },
          child: Image.asset(
            homeScrenImage[index],
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(serviceTypes[index], style: TextStyles.normalTextBlack),
      ],
    ),
  );
}
