import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/helpers/validators.dart';

Widget buildPasswordField(AuthenticationPage authenticationPage,
    TextEditingController passwordController) {
  return CustomTextField(
    validator: validatePassword,
    ispassword: true,
    controller: passwordController,
    text: 'Password',
    prefixIcon: Icon(Icons.fingerprint_outlined, color: greyColor),
    sufixIcon: authenticationPage == AuthenticationPage.login
        ? TextButton(
            onPressed: () {
              // Handle forgot password
            },
            child: Text(
              'Forgot?',
              style: TextStyles.linkText,
            ),
          )
        : Icon(Icons.visibility_outlined),
  );
}