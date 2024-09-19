import 'dart:developer';

import 'package:get/get.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log("On Init Called !");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    log("On Close Called !");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    log("On Ready Called !");
  }
}
