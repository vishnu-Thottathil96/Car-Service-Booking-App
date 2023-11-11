import 'package:flutter/material.dart';
import 'package:motox/data/models/model_user.dart';
import 'package:motox/presentation/screens/login&signup/widgets/back_button.dart';
import 'package:motox/presentation/screens/login&signup/widgets/confirm_password.dart';
import 'package:motox/presentation/screens/login&signup/widgets/email_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/footer.dart';
import 'package:motox/presentation/screens/login&signup/widgets/heading.dart';
import 'package:motox/presentation/screens/login&signup/widgets/link.dart';
import 'package:motox/presentation/screens/login&signup/widgets/name_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/password_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/submit_button.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';

class LoginAndSignupPage extends StatelessWidget {
  LoginAndSignupPage({super.key, required this.authenticationPage});
  final AuthenticationPage authenticationPage;
  final _formKey = GlobalKey<FormState>();

  final UserModel userModel = UserModel(id: 'uid', name: 'name', email: 'mail');

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
                  buildBackButton(context, authenticationPage),
                  buildHeadingAndDescription(authenticationPage),
                  if (authenticationPage == AuthenticationPage.signUp)
                    buildNameField(authenticationPage,
                        TextEditingControllers.nameController),
                  vertical20,
                  buildEmailField(authenticationPage,
                      TextEditingControllers.emailController),
                  vertical20,
                  buildPasswordField(authenticationPage,
                      TextEditingControllers.passwordController, context),
                  vertical20,
                  if (authenticationPage == AuthenticationPage.signUp)
                    buildConfirmPasswordField(
                        authenticationPage,
                        TextEditingControllers.confirmPasswordController,
                        TextEditingControllers.passwordController),
                  vertical20,
                  buildAuthenticationButton(
                      context,
                      _formKey,
                      authenticationPage,
                      TextEditingControllers.nameController,
                      TextEditingControllers.emailController,
                      TextEditingControllers.passwordController),
                  vertical20,
                  buildFooter(authenticationPage),
                  buildLinks(context, authenticationPage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
