import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:motox/data/repositories/auth_repository.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/login&signup/screen_login_signup.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

class MailVerificationPage extends StatelessWidget {
  const MailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MyScreenSize.screenWidth(context);
    double height = MyScreenSize.screenHeight(context);
    context.read<AuthBloc>().add(MailVerificationEvent());
    return WillPopScope(
      onWillPop: () async {
        AuthRepository.deleteUser();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginAndSignupPage(
                  authenticationPage: AuthenticationPage.signUp),
            ),
            (route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  vertical100,
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.authExceptions == AuthExceptions.verified) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                      }
                    },
                    child: Text(
                      'Verify your Email',
                      style: TextStyles.mainHeadingBlack,
                    ),
                  ),
                  vertical20,
                  SizedBox(
                      width: width,
                      height: height / 3.2,
                      child: Image.asset('assets/icons/mailverify.jpg')),
                  vertical20,
                  Text(
                    'Check your E-mail and click the link to activate your account',
                    textAlign: TextAlign.center,
                    style: TextStyles.normalTextGrey,
                  ),
                  Text(
                    'Incase not redirected to the home page after verification,press the confirm button',
                    textAlign: TextAlign.center,
                    style: TextStyles.normalTextGrey,
                  ),
                  vertical40,
                  GestureDetector(
                    onTap: () {
                      AuthRepository.confirmVerification()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ),
                            )
                          : Dialogs.showAlert(context, 'Verify Email',
                              'Click the link sent to your mail to verify');
                    },
                    child: Container(
                      width: width / 1.2,
                      height: height / 15,
                      decoration: BoxDecoration(
                          color: gradientOrange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'Confirm',
                        style: TextStyles.buttonText,
                      )),
                    ),
                  ),
                  vertical20,
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend Email',
                        style: TextStyles.linkText,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
