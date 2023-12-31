import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/login&signup/screen_login_signup.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int index;
  final PageController pageController;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    double width = MyScreenSize.screenWidth(context);
    double height = MyScreenSize.screenHeight(context);

    return Container(
      padding: EdgeInsets.all(width / 20),
      child: ListView(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginAndSignupPage(
                              authenticationPage: AuthenticationPage.login),
                        ),
                        (route) => false);
                  },
                  child: const Text('Skip'))),
          vertical60,
          SizedBox(
            width: width,
            height: height / 2.8,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
          vertical30,
          index == 2
              ? LargeButton(
                  text: 'Get Started',
                  context: context,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginAndSignupPage(
                              authenticationPage: AuthenticationPage.login),
                        ));
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
