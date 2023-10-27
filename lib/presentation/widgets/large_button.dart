import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/font_weights.dart';
import 'package:motox/utils/constants/screen_size.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.context,
    required this.onTap,
    required this.text,
  });

  final BuildContext context;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(context) {
    double width = MyScreenSize.screenHeight(context);
    double height = MyScreenSize.screenHeight(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
        ),
        width: width / 1.8,
        height: height / 15,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: whiteColor, fontWeight: MyFontWeights.bold),
        )),
      ),
    );
  }
}
