import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/login&signup/screen_login_signup.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/font_weights.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int index;
  final PageController pageController;

  OnboardingPage({
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
              child: TextButton(onPressed: () {}, child: Text('Skip'))),
          vertical60,
          SizedBox(
            width: width,
            height: height / 2.8,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
          vertical90,
          index == 2
              ? GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginAndSignupPage(
                            authenticationPage: AuthenticationPage.login),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    width: width / 1.8,
                    height: height / 15,
                    child: Center(
                        child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: whiteColor, fontWeight: MyFontWeights.bold),
                    )),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
