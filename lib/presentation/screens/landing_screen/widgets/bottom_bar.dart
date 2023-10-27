import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motox/business%20logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:motox/utils/constants/screen_size.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    return Container(
      margin: EdgeInsets.all(height / 28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BlocBuilder<BottomBarBloc, BottomBarState>(
          builder: (context, state) {
            return BottomNavigationBar(
                currentIndex: state.tabIndex,
                onTap: (value) {
                  context.read<BottomBarBloc>().add(TabChange(tabIndex: value));
                },
                showUnselectedLabels: true,
                elevation: 1,
                unselectedLabelStyle: TextStyle(color: Colors.black),
                backgroundColor: HexColor("#ffd9d9d9"),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black54,
                selectedIconTheme: const IconThemeData(color: Colors.blue),
                unselectedIconTheme: IconThemeData(color: Colors.black54),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.car_repair), label: 'Booking'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.help_outline_outlined), label: 'Help'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_outlined),
                      label: 'Profile'),
                ]);
          },
        ),
      ),
    );
  }
}
