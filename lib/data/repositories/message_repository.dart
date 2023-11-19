import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/data/models/model_message.dart';

class MessageRepository {
  final _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _fireStore.collection('chat').doc(userId).set({"userId": userId});
    final doc =
        _fireStore.collection('chat').doc(userId).collection('messages').doc();
    await doc.set({...message.toJson(), 'messageId': doc.id});
  }

  Stream<List<Message>> getChatMessagesStream(String userId) {
    return _fireStore
        .collection('chat')
        .doc(userId)
        .collection('messages')
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Message.fromJson(data);
      }).toList();
    });
  }
}
