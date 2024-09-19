import 'dart:developer';

import 'package:firebase_chat_app/controllers/chat_controller.dart';
import 'package:firebase_chat_app/controllers/home_controller.dart';
import 'package:firebase_chat_app/screens/home/components/live_user_list.dart';
import 'package:firebase_chat_app/screens/home/components/static_user_list.dart';
import 'package:firebase_chat_app/services/google_auth_services.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:firebase_chat_app/services/notification_helper.dart';
import 'package:firebase_chat_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("On Init Called !");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("On Dispose Called !");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      log("On Resume Called !");
    } else if (state == AppLifecycleState.inactive) {
      log("On Inactive Called !");
    } else if (state == AppLifecycleState.paused) {
      log("On Pause Called !");
    } else if (state == AppLifecycleState.detached) {
      log("On Detached Called !");
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    log("On Deactivate Called !");
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(MainController());
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
