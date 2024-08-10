import 'package:firebase_auth/firebase_auth.dart';

class LocalAuthServices {

  LocalAuthServices._();
  static final LocalAuthServices localAuthServices = LocalAuthServices._();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signWithEmailAndPassword(String email, String password)
  async {
    try
    {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password); 
      return "success";
    }catch(e)
    {
      return e.toString();
    }
  }

  Future<String> createAccountWithEmailAandPassword(String email,String password)
  async {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password); 
      return "success";
    }catch(e)
    {
      return e.toString();
    }
  }

  User? getCurrentUser()
   {
    User? user =  firebaseAuth.currentUser;
    return user;
  }
  
}