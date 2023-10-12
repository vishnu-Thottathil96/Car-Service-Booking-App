import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/otp/screen_otp.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/helpers/auth_results.dart';
import 'package:motox/utils/helpers/validators.dart';

class LoginAndSignupPage extends StatelessWidget {
  LoginAndSignupPage({super.key, required this.authenticationPage});
  final AuthenticationPage authenticationPage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authenticationPage == AuthenticationPage.login
                    ? vertical200
                    : vertical40,
                authenticationPage == AuthenticationPage.signUp
                    ? IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back))
                    : const SizedBox(),
                Text(
                  authenticationPage == AuthenticationPage.login
                      ? 'Login'
                      : 'Create Account',
                  style: TextStyles.mainHeadingBlack,
                ),
                vertical20,
                Text(
                  authenticationPage == AuthenticationPage.login
                      ? 'Please login to continue'
                      : '',
                  style: TextStyles.subheadingGrey,
                ),
                vertical20,
                authenticationPage == AuthenticationPage.login
                    ? const SizedBox()
                    : CustomTextField(
                        validator: validateName,
                        text: 'Name',
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: greyColor,
                        ),
                        controller: nameController,
                      ),
                vertical20,
                CustomTextField(
                  validator: validateEmail,
                  text: 'Email',
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: greyColor,
                  ),
                  controller: emailController,
                ),
                vertical30,
                CustomTextField(
                  validator: validatePassword,
                  ispassword: true,
                  controller: passwordController,
                  text: 'Password',
                  prefixIcon:
                      Icon(Icons.fingerprint_outlined, color: greyColor),
                  sufixIcon: authenticationPage == AuthenticationPage.login
                      ? TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot?',
                            style: TextStyles.linkText,
                          ))
                      : null,
                ),
                vertical30,
                authenticationPage == AuthenticationPage.login
                    ? const SizedBox()
                    : CustomTextField(
                        validator: (value) => validateConfirmPassword(
                            value, passwordController.text),
                        controller: confirmPasswordController,
                        text: 'Confirm Password',
                        prefixIcon:
                            Icon(Icons.fingerprint_outlined, color: greyColor),
                      ),
                vertical30,
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      state.authExceptions != null
                          ? resultShow(state.authExceptions!, context)
                          : null;
                    },
                    builder: (context, state) {
                      if (state.isSaving) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
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
                                    : 'SignUp')),
                      );
                    },
                  ),
                ),
                authenticationPage == AuthenticationPage.login
                    ? vertical100
                    : vertical30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(authenticationPage == AuthenticationPage.login
                        ? 'Don\'t have an account?'
                        : 'Already have an account?'),
                    TextButton(
                      onPressed: () {
                        authenticationPage == AuthenticationPage.login
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginAndSignupPage(
                                      authenticationPage:
                                          AuthenticationPage.signUp),
                                ))
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginAndSignupPage(
                                      authenticationPage:
                                          AuthenticationPage.login),
                                ));
                      },
                      child: Text(
                        authenticationPage == AuthenticationPage.login
                            ? 'Sign up'
                            : 'Login',
                        style: TextStyle(color: gradientOrange),
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandingPage(),
                          ));
                    },
                    child: Text('Test link to landing page')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(),
                          ));
                    },
                    child: Text('Test link to OTP page'))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
