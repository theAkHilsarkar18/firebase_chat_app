import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {

  GoogleAuthServices._();
  static final GoogleAuthServices googleAuthServices = GoogleAuthServices._();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signWithGoogle()
  async {
      try{
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn(); 
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );

        await firebaseAuth.signInWithCredential(authCredential);

        return "success";
      }catch(e)
      {
        return e.toString();
      }
  }

  Future<void> signOutFromGoogle()
  async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

}