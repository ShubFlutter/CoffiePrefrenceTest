import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future signIn({required String? email, required String? password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print("error $e");
    }
  }

  Future signUp({required String? email, required String? password}) async {
    // await FirebaseAuth.instance.
  }
}
