import 'package:firebase_chat_app/main.dart';
import 'package:firebase_chat_app/screens/auth/components/my_text_fields.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/signup.jpeg'),
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                  wordSpacing: 2,
                ),
              ),
              MyTextFields(
                lable: 'Name',
                controller: txtName,
              ),
              MyTextFields(
                lable: 'Phone',
                controller: txtPhone,
              ),
              MyTextFields(
                lable: 'Email',
                controller: txtEmail,
              ),
              MyTextFields(
                lable: 'Password',
                controller: txtPassword,
              ),
              MyTextFields(
                lable: 'Confirm Password',
                controller: txtConfirmPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (txtPassword.text == txtConfirmPassword.text) {
                      String status = await LocalAuthServices.localAuthServices
                          .createAccountWithEmailAandPassword(
                              txtEmail.text, txtPassword.text);

                      if (status == "success") {
                        Get.back();
                      } else {
                        Get.snackbar(
                            colorText: Colors.white,
                            'Sign Up Exception',
                            status);
                      }
                    } else {
                      Get.snackbar("Password doesn't match",
                          'Password and confirm password must be same !');
                    }
                  },
                  child: const Text('Sign Up')),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Already have account? Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var txtName = TextEditingController();
var txtPhone = TextEditingController();
var txtEmail = TextEditingController();
var txtPassword = TextEditingController();
var txtConfirmPassword = TextEditingController();
