import 'package:firebase_chat_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticUserList extends StatelessWidget {
  HomeController controller;
  StaticUserList({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.userList.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(controller.userList[index].image!),
          ),
          title: Text(controller.userList[index].name!),
          subtitle: Text(controller.userList[index].email!),
        ),
      ),
    );
  }
}
