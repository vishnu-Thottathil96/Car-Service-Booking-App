import 'package:flutter/material.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildHeadingAndDescription(AuthenticationPage authenticationPage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (authenticationPage == AuthenticationPage.login)
        vertical200
      else
        vertical40,
      Text(
        authenticationPage == AuthenticationPage.login
            ? 'Login'
            : 'Create Account',
        style: TextStyles.mainHeadingBlack,
      ),
      vertical20,
      Text(
        authenticationPage == AuthenticationPage.login
            ? 'Please login to continue'
            : '',
        style: TextStyles.subheadingGrey,
      ),
      vertical20,
    ],
  );
}
