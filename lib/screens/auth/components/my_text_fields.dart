import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextFields extends StatelessWidget {
  late String lable;
  late TextEditingController controller;

  MyTextFields({super.key, required this.lable, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          labelText: lable,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
