import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String message;
  final String sender;
  final String receiver;
  final String image;
  final Timestamp timestamp;

  Chat({
    required this.timestamp,
    required this.message,
    required this.sender,
    required this.image,
    required this.receiver,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'timestamp': timestamp,
      'image': image,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      sender: map['sender'],
      receiver: map['receiver'],
      message: map['message'],
      timestamp: map['timestamp'],
      image: map['image'],
    );
  }
}
