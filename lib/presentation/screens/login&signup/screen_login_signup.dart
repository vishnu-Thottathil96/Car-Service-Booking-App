import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/chat/screen_chat.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/login&signup/widgets/back_button.dart';
import 'package:motox/presentation/screens/login&signup/widgets/confirm_password.dart';
import 'package:motox/presentation/screens/login&signup/widgets/email_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/footer.dart';
import 'package:motox/presentation/screens/login&signup/widgets/heading.dart';
import 'package:motox/presentation/screens/login&signup/widgets/link.dart';
import 'package:motox/presentation/screens/login&signup/widgets/name_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/password_field.dart';
import 'package:motox/presentation/screens/login&signup/widgets/submit_button.dart';
import 'package:motox/presentation/screens/mail%20verification/screen_mailverify.dart';
import 'package:motox/presentation/screens/slot_selection/screen_slot.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';

class LoginAndSignupPage extends StatelessWidget {
  LoginAndSignupPage({super.key, required this.authenticationPage});
  final AuthenticationPage authenticationPage;
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
                      TextEditingControllers.passwordController),
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingPage(),
                            ));
                      },
                      child: Text('test link to landing page')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MailVerificationPage(),
                            ));
                      },
                      child: Text('test link to verification page')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ));
                      },
                      child: Text('test link to chat page')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SlotSelectionPage(),
                            ));
                      },
                      child: Text('test link to slot booking page')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
