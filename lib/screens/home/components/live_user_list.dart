import 'package:firebase_chat_app/model/user_model.dart';
import 'package:firebase_chat_app/services/get_user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';

var chatController = Get.put(ChatController());

// ignore: must_be_immutable
class LiveUserList extends StatelessWidget {
  LiveUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GetUserServices.getUserServices.getLiveUserList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<UserModel> userList = snapshot.data!.docs
            .map(
              (e) => UserModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              chatController.getSenderAndReceiver(userList[index]);
              Get.toNamed('/chat');
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(userList[index].image!),
              ),
              title: Text(userList[index].name!),
              subtitle: Text(userList[index].email!),
            ),
          ),
        );
      },
    );
  }
}
