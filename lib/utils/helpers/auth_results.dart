import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/utils/constants/enums.dart';

resultShow(AuthExceptions authExceptions, BuildContext context) {
  if (authExceptions == AuthExceptions.signUpSuccess) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ));
  } else if (authExceptions == AuthExceptions.loginSuccess) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ));
  } else {
    log('E R R O R');
  }
}
