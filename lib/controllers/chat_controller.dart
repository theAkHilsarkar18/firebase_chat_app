import 'package:get/get.dart';

class ChatController extends GetxController{
  RxList chatList = [].obs;

  void sendChat(String chat)
  {
    chatList.add(chat);
  }
}