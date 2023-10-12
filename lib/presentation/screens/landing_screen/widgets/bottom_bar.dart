import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BottomNavigationBar(
            showUnselectedLabels: true,
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 231, 228, 228),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: greyColor,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            unselectedIconTheme:
                const IconThemeData(color: Color.fromARGB(255, 125, 124, 124)),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_repair), label: 'Booking'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline_outlined), label: 'Help'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
            ]),
      ),
    );
  }
}
