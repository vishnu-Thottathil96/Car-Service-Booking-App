import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/font_weights.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MyScreenSize.screenWidth(context);
    double height = MyScreenSize.screenHeight(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              vertical20,
              Text(
                'OTP Verification',
                style: TextStyles.mainHeadingBlack,
              ),
              SizedBox(
                  width: width,
                  height: height / 3,
                  child: Image.asset('assets/icons/otppng.png')),
              Text(
                'Please enter the OTP sent to your Email to complete the verification process.',
                textAlign: TextAlign.center,
                style: TextStyles.normalTextGrey,
              ),
              vertical40,
              OtpTextField(
                fieldWidth: 55,
                numberOfFields: 5,
                focusedBorderColor: gradientOrange,
                enabledBorderColor: greyColor,
                showCursor: false,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end onSubmit
              ),
              vertical100
            ],
          ),
        ),
      ),
    );
  }
}
