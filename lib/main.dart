import 'dart:developer';

import 'package:firebase_chat_app/controllers/main_controller.dart';
import 'package:firebase_chat_app/firebase_options.dart';
import 'package:firebase_chat_app/screens/auth/auth_manager.dart';
import 'package:firebase_chat_app/screens/auth/sign_in.dart';
import 'package:firebase_chat_app/screens/auth/sign_up.dart';
import 'package:firebase_chat_app/screens/chat/chat_page.dart';
import 'package:firebase_chat_app/screens/home/home_page.dart';
import 'package:firebase_chat_app/services/firebase_messaging_services.dart';
import 'package:firebase_chat_app/services/get_servert_token.dart';
import 'package:firebase_chat_app/services/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// create background message handler to handle background message.

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification!.title}");
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.to(const UserPage());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.notificationHelper.notificationPlugin().then(
    (value) {
      log("Notification Initialization Done !");
    },
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessagingServices.firebaseMessagingServices.onMessageListener();

  // call onBackgroundMessage from Firebase Messaging and pass background message handler which above created
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await GetServerToken.instance.getServerToken();
  // Server token refresh on every hour so you can set it for refresh periodically or
  // uncomment getServerToken() and call each time the app built - preferable
  // or generate token from postman if error occur while generating server token
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const AuthManager(),
        ),
        GetPage(
          name: '/',
          page: () => const AuthManager(),
        ),
        GetPage(
          name: '/signIn',
          page: () => const SignInPage(),
        ),
        GetPage(
          name: '/signUp',
          page: () => const SignUpPage(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatPage(),
        ),
      ],
    );
  }
}
