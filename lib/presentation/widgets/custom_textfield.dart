import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.text,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.sufixIcon,
    this.prefixIcon,
    this.validator,
    this.ispassword = false,
    this.hint,
    this.contentPadding,
  }) : super(key: key);

  final String? text;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool ispassword;
  final String? hint;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ispassword,
      cursorColor: blackColor,
      style: TextStyle(color: blackColor),
      decoration: InputDecoration(
          contentPadding: contentPadding,
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          hintText: hint,
          labelText: text,
          labelStyle: TextStyle(color: blackColor),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: blackColor)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: blackColor))),
      controller: controller,
      keyboardType: keyboardType,
      maxLines: ispassword ? 1 : null,
      validator: validator,
    );
  }
}
