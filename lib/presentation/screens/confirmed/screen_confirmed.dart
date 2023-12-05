// import 'package:flutter/material.dart';
// import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
// import 'package:motox/utils/colors/colors.dart';
// import 'package:lottie/lottie.dart';
// import 'package:motox/utils/constants/screen_size.dart';

// class ConfirmedScreen extends StatelessWidget {
//   const ConfirmedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = MyScreenSize.screenHeight(context);
//     double width = MyScreenSize.screenWidth(context);
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LandingPage(),
//           ));
//     });

//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             height: height / 2,
//             width: width,
//             color: const Color.fromARGB(255, 238, 208, 115),
//             child: Lottie.asset('assets/icons/Animation - 1701195301291.json',
//                 fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }
