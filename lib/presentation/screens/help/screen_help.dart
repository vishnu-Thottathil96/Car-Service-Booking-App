import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/chat/screen_chat.dart';
import 'package:motox/presentation/screens/faq_page/screen_faq.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              vertical20,
              Text(
                'Enquiry',
                style: TextStyles.mainHeadingBlack,
              ),
              vertical20,
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/icons/support.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          navigateToScreen(context: context, index: index);
                        },
                        leading: SizedBox(
                          height: 40,
                          width: 50,
                          child: Image.asset(helpPageIcons[index]),
                        ),
                        title: Text(helpHeadings[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => vertical30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void navigateToScreen({required BuildContext context, required int index}) {
  switch (index) {
    case 0:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FAQPage(),
          ));
      break;
    case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ));
      break;
    case 2:
      showAlertToContact(context: context, contact: '8129152508');
      break;
    case 3:
      showAlertToContact(context: context, contact: 'motoxsupport@gmail.com');
      break;
  }
}

void _launchPhoneDialer(BuildContext context, String phoneNumber) async {
  Uri phoneUri = Uri.parse('tel:$phoneNumber');
  if (await launchUrl(phoneUri)) {
    // Dialer opened
  } else {
    // Dialer is not opened
  }
}

void _sendEmail(BuildContext context, String emailAddress) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
  );

  if (await launchUrl(emailUri)) {
    // Email app opened
  } else {
    // Email app could not be opened
  }
}

enum AlertAction {
  dial,
  email,
}

void handleAlertAction({
  required BuildContext context,
  required String content,
  required AlertAction action,
}) {
  switch (action) {
    case AlertAction.dial:
      _launchPhoneDialer(context, content);
      break;
    case AlertAction.email:
      _sendEmail(context, content);
  }
}

bool isNumeric(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}

void showAlertToContact(
    {required BuildContext context, required String contact}) {
  bool isPhoneNumber = isNumeric(contact);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: isPhoneNumber
            ? const Text('Dial for Assistance')
            : const Text('Reach Us by Email'),
        content: GestureDetector(
          onTap: () {
            isPhoneNumber
                ? handleAlertAction(
                    context: context,
                    content: contact,
                    action: AlertAction.dial)
                : handleAlertAction(
                    context: context,
                    content: contact,
                    action: AlertAction.email);
          },
          child: Text(
            contact,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
