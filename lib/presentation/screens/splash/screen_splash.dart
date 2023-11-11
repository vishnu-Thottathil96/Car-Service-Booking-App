// import 'package:flutter/material.dart';
// import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
// import 'package:motox/utils/colors/colors.dart';
// import 'package:motox/utils/constants/screen_size.dart';

// class ScreenSplash extends StatelessWidget {
//   const ScreenSplash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const OnBoardScreen(),
//         ),
//       );
//     });
//     double width = MyScreenSize.screenWidth(context);
//     //splashNavigate(context);
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: width,
//               //height: height / 5,
//               child: Image.asset(
//                 'assets/logo/splash2.gif',
//                 fit: BoxFit.cover,
//                 // height: height / 12,
//                 // width: width / 1.2,
//               ),
//             ),
//             // vertical20,
//             // const Align(

//             //   alignment: Alignment.center,
//             //   child: LinearProgressIndicator(),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   // void splashNavigate(context) async {
//   //   await Future.delayed(const Duration(seconds: 5));
//   //   Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => OnBoardScreen(),
//   //       ));
//   // }
// }
import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    _startDelayedNavigation();
  }

  void _startDelayedNavigation() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Check if the widget is still in the tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoardScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MyScreenSize.screenWidth(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Image.asset(
                'assets/logo/splash2.gif',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Cancel the delayed navigation if the widget is disposed
    // This is important to avoid the error you were encountering
    // Here, we don't need to cancel the navigation, so it's left empty.
    super.dispose();
  }
}
