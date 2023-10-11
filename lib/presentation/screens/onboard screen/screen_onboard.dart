import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/onboard%20screen/widgets/pageview.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OnboardingPageView()),
    );
  }
}
