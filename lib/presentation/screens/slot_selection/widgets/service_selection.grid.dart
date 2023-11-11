import 'package:flutter/material.dart';
import 'package:motox/data/models/model_service_item.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/service_item.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

Widget buildServiceSelectionGrid() {
  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 1,
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    ),
    itemCount: typesOfServices.length - 1,
    itemBuilder: (context, index) {
      final serviceItem = typesOfServices[index + 1];
      final heading = typesOfServices[index + 1].heading;
      final images = typesOfServices[index + 1].imagePath;
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => toggleServiceSelection(serviceItem),
            child: ServiceItemWidget(
              serviceItem: serviceItem,
              images: images,
            ),
          ),
          Text(heading.toString()),
        ],
      );
    },
  );
}

void toggleServiceSelection(ServiceItem serviceItem) {
  serviceItem.isSelected = !serviceItem.isSelected;
}
