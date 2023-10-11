import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/font_weights.dart';
import 'package:motox/utils/constants/space.dart';

class LoginAndSignupPage extends StatelessWidget {
  const LoginAndSignupPage({super.key, required this.authenticationPage});
  final AuthenticationPage authenticationPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Text(
                authenticationPage == AuthenticationPage.login
                    ? 'Login'
                    : 'SignUp',
                style: TextStyle(fontWeight: MyFontWeights.bold, fontSize: 30),
              ),
              Text(
                authenticationPage == AuthenticationPage.login
                    ? 'Please login to continue'
                    : 'Sign up to continue',
                style:
                    TextStyle(fontWeight: MyFontWeights.regular, fontSize: 20),
              ),
              authenticationPage == AuthenticationPage.login
                  ? const SizedBox()
                  : CustomTextField(
                      text: 'Full Name',
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        color: blackColor,
                      ),
                    ),
              vertical20,
              CustomTextField(
                text: 'Email',
                prefixIcon: Icon(
                  Icons.mail_outline_rounded,
                  color: blackColor,
                ),
              ),
              vertical20,
              CustomTextField(
                text: 'Password',
                prefixIcon: Icon(Icons.lock, color: blackColor),
                sufixIcon: authenticationPage == AuthenticationPage.login
                    ? TextButton(onPressed: () {}, child: Text('Forgot?'))
                    : null,
              ),
              vertical20,
              authenticationPage == AuthenticationPage.login
                  ? SizedBox()
                  : CustomTextField(
                      text: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock, color: blackColor),
                    ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    label: Text('Login')),
              ),
              Row(
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
                                      authenticationPage:
                                          AuthenticationPage.signUp),
                                ))
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginAndSignupPage(
                                      authenticationPage:
                                          AuthenticationPage.login),
                                ));
                      },
                      child: Text(
                        authenticationPage == AuthenticationPage.login
                            ? 'Sign up'
                            : 'Login',
                        style: TextStyle(color: gradientOrange),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
