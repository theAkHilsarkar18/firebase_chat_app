import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';

class ChatServices {
  static ChatServices chatServices = ChatServices._();
  ChatServices._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addChatToFirestore(
      Chat chat, String sender, String receiver) async {
    final chatCollection = firestore.collection("chatroom");
    List id = [sender, receiver];
    id.sort();
    String docId = id.join("_");
    try {
      await chatCollection.doc(docId).collection("chat").add(chat.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(
      String receiver, String sender) {
    final chatCollection = firestore.collection("chatroom");
    List id = [sender, receiver];
    id.sort();
    String docId = id.join("_");
    final userChat = chatCollection
        .doc(docId)
        .collection("chat")
        .orderBy('timestamp', descending: false)
        .snapshots();
    return userChat;
  }

  Future<void> deleteChat(String sender, String receiver) async {
    List id = [sender, receiver];
    id.sort();
    String docId = id.join("_");
    await firestore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc()
        .delete();
  }
}
