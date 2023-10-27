import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/helpers/validators.dart';

Widget buildConfirmPasswordField(
    AuthenticationPage authenticationPage,
    TextEditingController confirmPasswordController,
    TextEditingController passwordController) {
  return CustomTextField(
    validator: (value) =>
        validateConfirmPassword(value, passwordController.text),
    controller: confirmPasswordController,
    text: 'Confirm Password',
    prefixIcon: Icon(Icons.fingerprint_outlined, color: greyColor),
  );
}
