class Message {
  final String text;
  final bool isSendByMe;
  final DateTime date;
  Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
  });
}
