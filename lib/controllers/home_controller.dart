import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString userName = "No Name".obs;
  RxString userEmail = "".obs;
  RxString userPhotoUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDUYYpU49qnItl0Wqyu_nYHC_bLoFNFmtmZA&s"
          .obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
  }

  void getUserDetail() {
    User? user = LocalAuthServices.localAuthServices.getCurrentUser();
    
    userEmail = user!.email!.obs;
    if (user.photoURL != null || user.displayName != null) {
      userPhotoUrl = user.photoURL!.obs;
      userName = user.displayName!.obs;
    }
  }
}
