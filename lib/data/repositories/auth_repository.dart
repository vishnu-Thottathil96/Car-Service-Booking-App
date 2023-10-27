import 'dart:async';
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
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
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

  static Future<AuthExceptions> verifyMail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    final bool isEmailVerified =
        FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    if (isEmailVerified) {
      return AuthExceptions.verified;
    } else {
      Completer<AuthExceptions> completer = Completer();
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          timer.cancel();
          completer.complete(AuthExceptions.verified);
        }
      });
      return completer.future;
    }
  }

  static Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  static bool confirmVerification() {
    FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return true;
    }
    return false;
  }
}
