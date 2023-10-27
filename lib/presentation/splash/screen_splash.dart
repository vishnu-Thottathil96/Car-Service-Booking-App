import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    double width = MyScreenSize.screenWidth(context);
    splashNavigate(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              //height: height / 5,
              child: Image.asset(
                'assets/logo/splash2.gif',
                fit: BoxFit.cover,
                // height: height / 12,
                // width: width / 1.2,
              ),
            ),
            // vertical20,
            // const Align(

            //   alignment: Alignment.center,
            //   child: LinearProgressIndicator(),
            // ),
          ],
        ),
      ),
    );
  }

  void splashNavigate(context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardScreen(),
        ));
  }
}
