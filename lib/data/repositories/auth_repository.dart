import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/utils/constants/enums.dart';

class AuthRepository {
  static Future<AuthExceptions> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthExceptions.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthExceptions.weekPassword;
      } else if (e.code == 'email-already-in-use') {
        return AuthExceptions.emailAlreadyExist;
      } else {
        return AuthExceptions.somethingWentWrong;
      }
    }
  }

  static Future<AuthExceptions> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthExceptions.loginSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return AuthExceptions.wrongPassword;
      } else if (e.code == 'user-not-found') {
        return AuthExceptions.userNotFound;
      } else {
        return AuthExceptions.somethingWentWrong;
      }
    }
  }
}
