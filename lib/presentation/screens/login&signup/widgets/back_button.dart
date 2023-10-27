import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/login&signup/screen_login_signup.dart';
import 'package:motox/utils/constants/enums.dart';

Widget buildBackButton(
    BuildContext context, AuthenticationPage authenticationPage) {
  return authenticationPage == AuthenticationPage.signUp
      ? IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginAndSignupPage(
                      authenticationPage: AuthenticationPage.login),
                ));
          },
          icon: const Icon(Icons.arrow_back),
        )
      : const SizedBox();
}
