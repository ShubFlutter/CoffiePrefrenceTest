import 'package:crud_firebase_flutter/screens/auth/signin.dart';
import 'package:crud_firebase_flutter/firebase_options.dart';
import 'package:crud_firebase_flutter/screens/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: newMethod(),
        debugShowCheckedModeBanner: false,
        home: const SignIn());
  }

  ThemeData newMethod() {
    return ThemeData(
        cardTheme: const CardTheme(
          shadowColor: Color.fromARGB(255, 243, 214, 0),
          surfaceTintColor: Colors.pink,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.pink),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.amber,
          elevation: 5,
        ),
        textTheme: const TextTheme(
            displaySmall:
                TextStyle(fontSize: 15, color: Color.fromARGB(255, 202, 0, 0))),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple));
  }
}
