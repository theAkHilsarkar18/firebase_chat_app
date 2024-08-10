import 'package:firebase_chat_app/controllers/home_controller.dart';
import 'package:firebase_chat_app/services/google_auth_services.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          width: 300,
          child: Obx(
            () => Column(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      controller.userPhotoUrl.value,
                    ),
                  ),
                ),
                Text(controller.userName.value),
                Text(controller.userEmail.value),
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () async {
                  await GoogleAuthServices.googleAuthServices
                      .signOutFromGoogle();
                  if (LocalAuthServices.localAuthServices.getCurrentUser() ==
                      null) {
                    Get.offAndToNamed('/signIn');
                  }
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/homeBg.jpg'),
            ),
          ),
          // child: const Column(
          //   children: [],
          // ),
        ),
      ),
    );
  }
}
