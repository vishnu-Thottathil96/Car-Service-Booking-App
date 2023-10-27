import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/mail%20verification/screen_mailverify.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/helpers/auth_results.dart';

Widget buildAuthenticationButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    AuthenticationPage authenticationPage,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authExceptions == AuthExceptions.signUpSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MailVerificationPage(),
              ));
        } else if (state.authExceptions == AuthExceptions.loginSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LandingPage(),
              ));
        }
        if (state.authExceptions != AuthExceptions.initial) {
          resultShow(state.authExceptions, context);
        }
      },
      builder: (context, state) {
        if (state.isSaving) {
          return const Center(child: CircularProgressIndicator());
        }
        return Align(
          alignment: Alignment.topRight,
          child: ElevatedButton.icon(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                authenticationPage == AuthenticationPage.login
                    ? context.read<AuthBloc>().add(LoginEvent(
                        email: emailController.text,
                        password: passwordController.text))
                    : context.read<AuthBloc>().add(SignUpEvent(
                        email: emailController.text,
                        name: nameController.text,
                        password: passwordController.text));
              }
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(
              authenticationPage == AuthenticationPage.login
                  ? 'Login'
                  : 'SignUp',
            ),
          ),
        );
      },
    ),
  );
}
