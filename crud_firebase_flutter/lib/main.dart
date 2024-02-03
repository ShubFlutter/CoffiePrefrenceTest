import 'package:crud_firebase_flutter/firebase/firestore.dart';
import 'package:crud_firebase_flutter/firebase_options.dart';
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
    return MaterialApp(home: Notes());
  }
}

class Notes extends StatelessWidget {
  Notes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: (Container(
        child: ListView(children: [
          Center(
            child: Text(
              "Notes",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          Hspace(),
          CustomForm(),
        ]),
      )),
    );
  }
}

class CustomForm extends StatefulWidget {
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final FirestoreService firestoreService = FirestoreService();
  final formkey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Container(
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _notesController,
                  validator: (value) =>
                      value!.isEmpty ? "Please fill the details" : null,
                  decoration: InputDecoration(label: Text("Enter Notes")),
                ),
                Hspace(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            formkey.currentState!.save();
                          });
                          dynamic data = firestoreService
                              .addNotes("${_notesController.text}");
                          data.then((dataa) {
                            print("sucessfully  ${dataa.id}");
                          });
                          _notesController.clear();
                        }
                      },
                      child: Text("Submit")),
                  Wspace(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _notesController.clear();
                        });
                      },
                      child: Text("Clear")),
                ]),
                Hspace(),
                Text("${_notesController.text}")
              ],
            )),
      )),
    );
  }
}

class Wspace extends StatelessWidget {
  const Wspace({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: 20);
}

class Hspace extends StatelessWidget {
  const Hspace({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: 20);
}
