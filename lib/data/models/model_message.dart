import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isSendByMe;
  final DateTime date;
  final String userId;
  final bool seenByAdmin;
  final bool seenByUser;
  Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
    required this.userId,
    required this.seenByAdmin,
    required this.seenByUser,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      isSendByMe: json['isSendByMe'],
      date: (json['date'] as Timestamp).toDate(),
      userId: json['userId'],
      seenByAdmin: json['seenByAdmin'],
      seenByUser: json['seenByUser'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSendByMe': isSendByMe,
      'date': Timestamp.fromDate(date),
      'userId': userId,
      'seenByAdmin': seenByAdmin,
      'seenByUser': seenByAdmin,
    };
  }
}
