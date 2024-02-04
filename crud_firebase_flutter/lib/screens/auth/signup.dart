import 'package:crud_firebase_flutter/screens/auth/signin.dart';
import 'package:crud_firebase_flutter/screens/notes.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign Up",
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
  const CustomForm({super.key});

  @override
  State<StatefulWidget> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formkey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
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
                    value!.isEmpty ? "Please provide username" : null,
                controller: _userNameController,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              const Hspace(),
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
                    }
                  },
                  child: const Text("submit")),
              const Hspace(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Text("Already Register Click here")),
              const Hspace(),
              Text(_email ?? ""),
              Text(_password ?? "")
            ],
          ),
        ));
  }
}
