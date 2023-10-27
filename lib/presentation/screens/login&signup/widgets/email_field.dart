import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/helpers/validators.dart';

Widget buildEmailField(AuthenticationPage authenticationPage,
    TextEditingController emailController) {
  return CustomTextField(
    validator: validateEmail,
    text: 'Email',
    prefixIcon: Icon(
      Icons.mail_outline_rounded,
      color: greyColor,
    ),
    controller: emailController,
  );
}
