import 'package:firebase_chat_app/controllers/home_controller.dart';
import 'package:firebase_chat_app/screens/home/components/live_user_list.dart';
import 'package:firebase_chat_app/screens/home/components/static_user_list.dart';
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
          width: 250,
          child: Container(
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/img/drawer.jpeg',
                ),
              ),
            ),
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
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      controller.userName.value,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    title: Text(
                      controller.userEmail.value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    title: Text(
                      controller.userPhone.value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
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
                  controller.clearUserListForLogOut();
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
          // child: StaticUserList(controller: controller),
          child: LiveUserList(),
        ),
      ),
    );
  }
}
