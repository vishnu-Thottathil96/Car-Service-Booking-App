import 'package:flutter/material.dart';
import 'package:motox/data/models/model_service_item.dart';
import 'package:motox/utils/colors/colors.dart';

class ServiceItemWidget extends StatefulWidget {
  final ServiceItem serviceItem;
  final String images;

  const ServiceItemWidget({
    super.key,
    required this.serviceItem,
    required this.images,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ServiceItemWidgetState createState() => _ServiceItemWidgetState();
}

class _ServiceItemWidgetState extends State<ServiceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle the isSelected property of the ServiceItem
          widget.serviceItem.isSelected = !widget.serviceItem.isSelected;
        });
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.images,
              fit: BoxFit.contain,
            ),
          ),
          if (widget.serviceItem.isSelected)
            Positioned.fill(
              child: Container(
                color: Colors.blue.withOpacity(0.5),
                child: Icon(
                  Icons.check_box,
                  color: greenColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
