import 'package:crud_firebase_flutter/screens/auth/signin.dart';
import 'package:crud_firebase_flutter/firebase_options.dart';
import 'package:crud_firebase_flutter/screens/notes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: newMethod(),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }

  ThemeData newMethod() {
    return ThemeData(
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 253, 17, 17)))),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 135, 30, 233),
            foregroundColor: Colors.white),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("error"));
          } else if (snapshot.hasData) {
            return const Notes();
          } else {
            return const SignIn();
          }
        });
  }
}
