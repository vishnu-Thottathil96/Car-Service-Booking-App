import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:motox/data/repositories/auth_repository.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    double width = MyScreenSize.screenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                ),
                vertical50,
                SizedBox(
                  height: height / 7,
                  width: width / 2.6,
                  child: Image.asset('assets/icons/reset-password.png'),
                ),
                vertical40,
                Text(
                  'Forgot Password',
                  style: TextStyles.subheadingBlack,
                ),
                vertical20,
                Text(
                  'Enter your E mail id and we will send you a link to reset your password',
                  style: TextStyles.normalTextGrey,
                  textAlign: TextAlign.center,
                ),
                vertical40,
                Form(
                  key: _formKey,
                  child: TextFormField(
                    cursorColor: blackColor,
                    style: TextStyle(color: blackColor),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: greyColor,
                        ),
                        hintText: 'Enter your Email here . . .',
                        labelStyle: TextStyle(color: blackColor),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor))),
                    controller:
                        TextEditingControllers.passwordResetMailController,
                    validator: (value) {
                      if (!isEmailValid(value)) {
                        return 'Please enter valid email address.';
                      }
                      return null;
                    },
                  ),
                ),
                vertical20,
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthRepository.resetPassword(
                              email: TextEditingControllers
                                  .passwordResetMailController.text);
                          log('Reset mail send');
                          Dialogs.showAlert(context, 'Resend Successful',
                              'Your password reset link has been resent successfully. Please check your email');
                        }
                      },
                      child: const Text(
                        'Resend Link',
                      )),
                ),
                vertical20,
                LargeButton(
                    context: context,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AuthRepository.resetPassword(
                            email: TextEditingControllers
                                .passwordResetMailController.text);
                        log('Reset mail send');
                        Dialogs.showAlert(
                          context,
                          'Reset email sent successfully',
                          'Password reset link has been sent to ${TextEditingControllers.passwordResetMailController.text}',
                        );
                      }
                    },
                    text: 'Submit'),
                vertical20,
                TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    label: const Text(
                      'Back to Login',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isEmailValid(String? email) {
  if (email == null || email.isEmpty) {
    return false; // Return false for null or empty email
  }

  // Define the regular expression pattern for a valid email address
  const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

  // Create a RegExp instance
  final regExp = RegExp(emailPattern);

  // Use the hasMatch method to test the email
  return regExp.hasMatch(email);
}
