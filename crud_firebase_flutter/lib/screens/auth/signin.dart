import 'package:crud_firebase_flutter/database/auth/auth.dart';
import 'package:crud_firebase_flutter/screens/auth/signup.dart';
import 'package:crud_firebase_flutter/screens/notes.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign In",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.green),
              ),
            ),
          ),
          const Hspace(),
          const CustomForm()
        ],
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Please provide email" : null,
                controller: _emailController,
                decoration: const InputDecoration(hintText: "email"),
              ),
              const Hspace(),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Please provide password" : null,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "password"),
              ),
              const Hspace(),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        _email = _emailController.text;
                        _password = _passwordController.text;
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      authService.signIn(email: _email, password: _password);
                      
                    }
                  },
                  child: const Text("Sign In")),
              const Hspace(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text("Click here to register")),
              const Hspace(),
              Text(_email ?? ""),
              Text(_password ?? "")
            ],
          ),
        ));
  }
}
