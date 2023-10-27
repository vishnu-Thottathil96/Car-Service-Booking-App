import 'package:flutter/material.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/space.dart';

Widget buildFooter(AuthenticationPage authenticationPage) {
  return authenticationPage == AuthenticationPage.login
      ? vertical100
      : vertical30;
}
