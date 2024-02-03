import 'package:coffieprefrenn/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
          backgroundColor: Colors.brown.shade600,
          elevation: 0,
          title: Text("SignIn")),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.SignInAnon();
            if (result != null) {
              print("sign in");
              print(result);
            } else {
              print("error");
            }
          },
          child: Text("Sign in"),
        ),
      ),
    );
  }
}
