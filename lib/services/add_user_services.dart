import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/model/user_model.dart';

class AddUserServices {
  AddUserServices._();
  static final AddUserServices addUserServices = AddUserServices._();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
