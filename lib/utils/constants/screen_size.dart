import 'package:flutter/widgets.dart';

class MyScreenSize {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
/*
// Example usage
double width = MyScreenSize.screenWidth(context);
double height = MyScreenSize.screenHeight(context);

// Use width and height as needed in your app
*/