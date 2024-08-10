import 'package:firebase_chat_app/screens/auth/sign_in.dart';
import 'package:firebase_chat_app/screens/home/home_page.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (LocalAuthServices.localAuthServices.getCurrentUser() == null)
        ? const SignInPage()
        : HomePage();
  }
}
