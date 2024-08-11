import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/model/user_model.dart';
import 'package:firebase_chat_app/screens/auth/components/my_text_fields.dart';
import 'package:firebase_chat_app/services/add_user_services.dart';
import 'package:firebase_chat_app/services/google_auth_services.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/login.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  MyTextFields(lable: 'Email', controller: txtEmail),
                  MyTextFields(lable: 'Password', controller: txtPassword),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String email = txtEmail.text;
                      String password = txtPassword.text;
                      String status = await LocalAuthServices.localAuthServices
                          .signWithEmailAndPassword(email, password);

                      if (status == 'success') {
                        Get.snackbar(
                            'Welcome in App,', 'Sign In Successfully !');
                      } else {
                        Get.snackbar('Sign In Exception !', status);
                      }
                      if (LocalAuthServices.localAuthServices
                              .getCurrentUser() !=
                          null) {
                        Get.offAndToNamed('/home');
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/signUp');
                    },
                    child: const Text(
                      "Don't have account? Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(Buttons.google, onPressed: () async {
                await GoogleAuthServices.googleAuthServices.signWithGoogle();

                User? user =
                    LocalAuthServices.localAuthServices.getCurrentUser();
                if (user != null) {
                  Map m1 = {
                    'uId': user.uid,
                    'name': user.displayName,
                    'email': user.email,
                    'image': user.photoURL,
                    'token': user.email,
                    'phone': user.phoneNumber ?? '+91 98254 8XXXX',
                    'password': 'PASSWORD',
                  };
                  UserModel userModel = UserModel.fromMap(m1);

                  String status = await AddUserServices.addUserServices
                      .addUserInFirestore(userModel);

                  if (status == "success") {
                    Get.offAndToNamed('/home');
                  } else {
                    Get.snackbar("User not added !", status);
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

var txtEmail = TextEditingController();
var txtPassword = TextEditingController();
