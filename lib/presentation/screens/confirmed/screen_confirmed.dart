import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/utils/colors/colors.dart';

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ));
    });

    return Scaffold(
      backgroundColor: whiteColor,
      body: const SafeArea(
        child: Center(
          child: Image(image: AssetImage('assets/icons/confirm.jpg')),
        ),
      ),
    );
  }
}
