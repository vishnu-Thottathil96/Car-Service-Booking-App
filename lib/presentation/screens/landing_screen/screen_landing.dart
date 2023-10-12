import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/booking/screen_booking.dart';
import 'package:motox/presentation/screens/help/screen_help.dart';
import 'package:motox/presentation/screens/home/screen_home.dart';
import 'package:motox/presentation/screens/landing_screen/widgets/bottom_bar.dart';
import 'package:motox/presentation/screens/profile/screen_profile.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final List pages = [
    const HomeScreen(),
    const BookingScreen(),
    const HelpScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
