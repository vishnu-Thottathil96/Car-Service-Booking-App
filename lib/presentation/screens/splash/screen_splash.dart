import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    _checkConnectivityAndNavigate();
  }

  void _checkConnectivityAndNavigate() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      _startDelayedNavigation();
    } else {
      _showNoNetworkAlert();
    }
  }

  void _startDelayedNavigation() {
    Future.delayed(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardScreen(),
          ),
        );
      }
    });
  }

  void _showNoNetworkAlert() {
    double screenHeight = MyScreenSize.screenHeight(context);
    double screenWidth = MyScreenSize.screenWidth(context);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: screenHeight / 2.5,
          width: screenWidth / 1.2,
          child: Column(
            children: [
              Container(
                height: screenHeight / 5,
                color: redColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons
                            .signal_wifi_statusbar_connected_no_internet_4_rounded,
                        color: whiteColor,
                        size: screenWidth / 4.5,
                      ),
                      Text(
                        'No Internet !',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight / 5,
                color: whiteColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Please check your internet connection and try again.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _checkConnectivityAndNavigate();
                          },
                          child: const Text('Retry'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            SystemNavigator.pop();
                          },
                          child: const Text('Close App'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MyScreenSize.screenWidth(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width / 1.6,
                  child: Image.asset('assets/logo/motoxlogo.png'),
                ),
                SizedBox(
                  width: width / 1.2,
                  child: Lottie.asset(
                    'assets/icons/splashlottie.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
