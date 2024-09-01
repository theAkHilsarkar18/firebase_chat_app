import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/model/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AddUserServices {
  AddUserServices._();

  static final AddUserServices addUserServices = AddUserServices._();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setTokenInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await firebaseMessaging.getToken();
    // firebaseMessaging.
    log("Token : $token");
    await firebaseFirestore.collection("users").doc(user!.email).update(
      {
        "token": token,
      },
    );
  }

  Future<String> addUserInFirestore(UserModel user) async {
    try {
      final CollectionReference userCollection =
          firebaseFirestore.collection("users");
      await userCollection.doc(user.email).set(user.toMap(user));
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
