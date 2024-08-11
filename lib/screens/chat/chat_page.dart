import 'package:firebase_chat_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Chat Page'),
          actions: [
            IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/chatBg.png'),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        controller.chatList.length,
                        (index) =>
                            ListTile(trailing: Text(controller.chatList[index])),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: const EdgeInsets.only(left: 20, top: 5),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  controller: txtChat,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton.filled(
                      color: Colors.white54,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.black26,
                        ),
                      ),
                      onPressed: () {
                        controller.sendChat(txtChat.text);
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController txtChat = TextEditingController();
