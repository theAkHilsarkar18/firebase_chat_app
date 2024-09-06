import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/model/user_model.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList chatList = [].obs;
  RxString sender = ''.obs;
  RxString receiverEmail = ''.obs;
  RxString receiverPhoto = ''.obs;
  RxString receiverName = ''.obs;
  RxString receiverToken = ''.obs;

  void getSenderAndReceiver(UserModel receiver) {
    User? user = LocalAuthServices.localAuthServices.getCurrentUser();
    sender.value = user!.email!;
    receiverEmail.value = receiver.email!;
    receiverName.value = receiver.name!;
    receiverPhoto.value = receiver.image!;
    receiverToken.value = receiver.token!;
  }

  void sendChat(String chat) {
    chatList.add(chat);
  }
}
