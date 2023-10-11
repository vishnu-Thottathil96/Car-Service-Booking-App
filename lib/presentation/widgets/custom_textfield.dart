import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.text,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.sufixIcon,
    required this.prefixIcon,
  }) : super(key: key);

  final String text;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Widget? sufixIcon;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: blackColor,
      style: TextStyle(color: blackColor),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          labelText: text,
          labelStyle: TextStyle(color: blackColor),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: blackColor)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: blackColor))),
      controller: controller,
      keyboardType: keyboardType,
      maxLines: null,
    );
  }
}
