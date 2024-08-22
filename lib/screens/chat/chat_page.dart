import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/chat_controller.dart';
import 'package:firebase_chat_app/screens/home/components/live_user_list.dart';
import 'package:firebase_chat_app/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/chat_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Obx(
            () => Text(
              chatController.receiverName.value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          actions: [
            CircleAvatar(
              radius: 19,
              backgroundImage: NetworkImage(chatController.receiverPhoto.value),
            ),
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
                child: StreamBuilder(
                  stream: ChatServices.chatServices.getChatList(
                      chatController.receiverEmail.value,
                      chatController.sender.value),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<Chat> chatList = snapshot.data!.docs
                        .map(
                          (e) => Chat.fromMap(e.data()),
                        )
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          chatList.length,
                          (index) => Row(
                            mainAxisAlignment: (chatList[index].sender ==
                                    chatController.sender.value)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    ChatServices.chatServices.deleteChat(
                                        chatController.sender.value,
                                        chatController.receiverEmail.value);
                                  },
                                  child: Container(
                                    // width: 250,
                                    margin: EdgeInsets.only(
                                        left: (chatList[index].sender ==
                                                chatController
                                                    .receiverEmail.value)
                                            ? 8
                                            : 50,
                                        top: 8,
                                        bottom: 8,
                                        right: (chatList[index].sender ==
                                                chatController
                                                    .receiverEmail.value)
                                            ? 50
                                            : 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      chatList[index].message,
                                      softWrap: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: const EdgeInsets.only(left: 20),
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
                      onPressed: () async {
                        chatController.sendChat(txtChat.text);

                        Chat chat = Chat.fromMap({
                          'sender': chatController.sender.value,
                          'receiver': chatController.receiverEmail.value,
                          'message': txtChat.text,
                          'timestamp': Timestamp.now(),
                        });

                        await ChatServices.chatServices.addChatToFirestore(
                            chat,
                            chatController.sender.value,
                            chatController.receiverEmail.value);
                        txtChat.clear();
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
