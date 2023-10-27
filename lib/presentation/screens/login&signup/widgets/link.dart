import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/login&signup/screen_login_signup.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';

Widget buildLinks(BuildContext context, AuthenticationPage authenticationPage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(authenticationPage == AuthenticationPage.login
          ? 'Don\'t have an account?'
          : 'Already have an account?'),
      TextButton(
        onPressed: () {
          authenticationPage == AuthenticationPage.login
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginAndSignupPage(
                        authenticationPage: AuthenticationPage.signUp),
                  ))
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginAndSignupPage(
                        authenticationPage: AuthenticationPage.login),
                  ));
        },
        child: Text(
          authenticationPage == AuthenticationPage.login ? 'Sign up' : 'Login',
          style: TextStyle(color: gradientOrange),
        ),
      ),
    ],
  );
}
