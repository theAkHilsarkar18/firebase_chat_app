import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';

class ChatServices {
  static ChatServices chatServices = ChatServices._();
  ChatServices._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addChatToFirestore(Chat chat) async {
    final chatCollection = firestore.collection("chatroom");
    try {
      await chatCollection
          .doc(chat.receiver)
          .collection("chat")
          .add(chat.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(String email) {
    final chatCollection = firestore.collection("chatroom");
    final userChat = chatCollection
        .doc(email)
        .collection("chat")
        .orderBy('timestamp', descending: false)
        .snapshots();
    return userChat;
  }
}
