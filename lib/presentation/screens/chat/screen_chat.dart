import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:motox/data/models/model_message.dart';
import 'package:motox/data/repositories/message_repository.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    double width = MyScreenSize.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: gradientOrange,
        toolbarHeight: 65,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/home_screen_images/paul.png',
            ),
          ),
        ),
        title: Text(
          'User Name',
          style: TextStyles.buttonText,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: MessageRepository().getChatMessagesStream(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  List<Message>? messages = snapshot.data;

                  return GroupedListView<Message, DateTime>(
                    controller: _scrollController,
                    elements: messages ?? [],
                    groupBy: ((message) => DateTime(
                          message.date.year,
                          message.date.month,
                          message.date.day,
                        )),
                    groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: greyColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              message.date.day == DateTime.now().day
                                  ? 'Today'
                                  : DateFormat.yMMMd().format(message.date),
                              style: TextStyles.normalTextWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Message message) => Align(
                      alignment: message.isSendByMe
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: message.isSendByMe
                              ? Colors.lightBlue[100]
                              : whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: width / 2.5,
                              child: Column(
                                children: [
                                  Text(message.text),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat.jm().format(message.date),
                                        style: TextStyle(
                                            color: greyColor, fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: height / 15,
              color: Colors.grey.shade300,
              child: Form(
                key: _formKey,
                child: FocusScope(
                  child: CustomTextField(
                    controller: TextEditingControllers.chatController,
                    hint: 'Type your message here...',
                    sufixIcon: IconButton(
                      onPressed: () {
                        if (TextEditingControllers
                            .chatController.text.isNotEmpty) {
                          final message = Message(
                            text: TextEditingControllers.chatController.text,
                            date: DateTime.now(),
                            isSendByMe: true,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          );
                          MessageRepository().sendMessage(message);
                        }

                        FocusScope.of(context).requestFocus(FocusNode());
                        _formKey.currentState!.reset();
                        // Scroll to the bottom after adding a new message
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Icon(Icons.send),
                    ),
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
