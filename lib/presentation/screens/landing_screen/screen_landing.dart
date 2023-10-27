// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:motox/business%20logic/blocs/bottom_bar/bottom_bar_bloc.dart';
// import 'package:motox/presentation/screens/booking/screen_booking.dart';
// import 'package:motox/presentation/screens/help/screen_help.dart';
// import 'package:motox/presentation/screens/home/screen_home.dart';
// import 'package:motox/presentation/screens/landing_screen/widgets/bottom_bar.dart';
// import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
// import 'package:motox/presentation/screens/profile/screen_profile.dart';

// class LandingPage extends StatelessWidget {
//   LandingPage({super.key});
//   final List pages = [
//     const HomeScreen(),
//     const BookingScreen(),
//     const HelpScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OnBoardScreen(),
//                   ),
//                   (route) => false);
//             },
//             icon: Icon(Icons.logout)),
//       ),
//       body: SafeArea(child: BlocBuilder<BottomBarBloc, BottomBarState>(
//         builder: (context, state) {
//           return pages[state.tabIndex];
//         },
//       )),
//       bottomNavigationBar: BottomBarWidget(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/bottom_bar/bottom_bar_bloc.dart';
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
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //         Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const OnBoardScreen(),
      //             ),
      //             (route) => false);
      //       },
      //       icon: Icon(Icons.logout)),
      // ),
      body: Stack(
        children: [
          SafeArea(
            child: BlocBuilder<BottomBarBloc, BottomBarState>(
              builder: (context, state) {
                return pages[state.tabIndex];
              },
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomBarWidget(),
          ),
        ],
      ),
    );
  }
}
