import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/home/widgets/section_poster.dart';
import 'package:motox/presentation/screens/home/widgets/section_services.dart';
import 'package:motox/presentation/screens/home/widgets/section_userinfo.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildUserInfoSection(context),
                vertical20,
                buildPosterSection(context),
                vertical20,
                buildServiceTypesSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
