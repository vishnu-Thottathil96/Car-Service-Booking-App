import 'package:flutter/material.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

resultShow(AuthExceptions authExceptions, BuildContext context) {
  if (authExceptions == AuthExceptions.signUpSuccess) {
    Dialogs.showSnackbar(context, 'Success', greenColor);
  } else if (authExceptions == AuthExceptions.loginSuccess) {
    Dialogs.showSnackbar(context, 'Success', greenColor);
  } else if (authExceptions == AuthExceptions.userNotFound) {
    Dialogs.showSnackbar(context, 'User Not Found', redColor);
  } else if (authExceptions == AuthExceptions.emailAlreadyExist) {
    Dialogs.showSnackbar(context, 'Mail id already used', redColor);
  } else if (authExceptions == AuthExceptions.weekPassword) {
    Dialogs.showSnackbar(
        context, 'Password must contain atleast 6 letters', redColor);
  } else if (authExceptions == AuthExceptions.wrongPassword) {
    Dialogs.showSnackbar(context, 'Wrong Password', redColor);
  } else {
    Dialogs.showSnackbar(context, 'Something went wrong', redColor);
  }
}
