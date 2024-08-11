import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/model/user_model.dart';
import 'package:firebase_chat_app/services/get_user_services.dart';
import 'package:firebase_chat_app/services/local_auth_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<UserModel> userList = <UserModel>[].obs;

  RxString userName = "No Name".obs;
  RxString userEmail = "".obs;
  RxString userPhotoUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDUYYpU49qnItl0Wqyu_nYHC_bLoFNFmtmZA&s"
          .obs;
  RxString userPhone = "+91 98254X XXXX".obs;        

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    // getUserData();
  }

  Future<void> getUserDetail() async {
    User? user = LocalAuthServices.localAuthServices.getCurrentUser();

    // userEmail = user!.email!.obs;
    // if (user.photoURL != null || user.displayName != null) {
    //   userPhotoUrl = user.photoURL!.obs;
    //   userName = user.displayName!.obs;

    // }

    Map? m1 = await GetUserServices.getUserServices.getUserByEmail(user!.email!);
    if(m1!.isNotEmpty)
    {
         UserModel user = UserModel.fromMap(m1);
         userEmail.value = user.email!;
         userName.value = user.name!;
         userPhone.value = user.phone!;
         userPhotoUrl.value = user.image!;
    }

  }

  Future<void> getUserData() async {
    final users = await GetUserServices.getUserServices.getUserList();
    userList.value = users
        .map(
          (e) => UserModel.fromMap(e),
        )
        .toList();
  }

  void clearUserListForLogOut() {
    userList.clear();
  }
}
