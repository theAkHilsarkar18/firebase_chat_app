import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserServices {
  static final getUserServices = GetUserServices._();
  GetUserServices._();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> userData = [];

  Future<List<Map<String, dynamic>>> getUserList() async {
    // find collection
    final CollectionReference userCollection =
        firebaseFirestore.collection("users");
    // get collection
    final QuerySnapshot snapshot = await userCollection.get();
    // get list of docs from collections
    final List<QueryDocumentSnapshot> docsList = snapshot.docs;
    // take each doc from docs list and convert into map format
    // after add into userData list
    for (var docs in docsList) {
      userData.add(docs.data() as Map<String, dynamic>);
    }
    return userData;
  }

  Stream<QuerySnapshot<Object?>> getLiveUserList(String currentUser) {
    final CollectionReference userCollection =
        firebaseFirestore.collection("users");
    final Stream<QuerySnapshot> snapshot =
        userCollection.where('email', isNotEqualTo: currentUser).snapshots();
    return snapshot;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    // create collection - find collection
    final userCollection = firebaseFirestore.collection("users");
    // find doc from all collection based on email - doc id
    final userDoc = userCollection.doc(email);
    final docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      // Handle case where document doesn't exist
      return null;
    }
  }
}
