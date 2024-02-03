import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future SignInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? uid = result.user;

      return uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
