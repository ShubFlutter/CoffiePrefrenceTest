import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_flutter/database/firebase/firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickerfile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Notes"),
      ),
      body: (ListView(children: [
        Center(
          child: Text(
            "Notes",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
        ),
        const Hspace(),
        if (pickerfile != null) Text(pickerfile!.name),
        if (pickerfile != null) Image.file(File(pickerfile!.path!)),
        const Hspace(),
        ElevatedButton(onPressed: selectfile, child: Text("select file")),
        ElevatedButton(onPressed: uploadFile, child: Text("upload")),
        const Hspace(),
        const CustomForm(),
      ])),
    );
  }

  PlatformFile? pickerfile;

  Future uploadFile() async {
    final path = "${"file/" + pickerfile!.name}";
    final file = File(pickerfile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final FirestoreService firestoreService = FirestoreService();
  final formkey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Form(
          key: formkey,
          child: ListView(
            shrinkWrap: true,
            children: [
              UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Card(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "deo",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.green),
                    ),
                  )),
                ),
              ),
              TextFormField(
                controller: _notesController,
                validator: (value) =>
                    value!.isEmpty ? "Please fill the details" : null,
                decoration: const InputDecoration(label: Text("Enter Notes")),
              ),
              const Hspace(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          formkey.currentState!.save();
                        });
                        dynamic data =
                            firestoreService.addNotes(_notesController.text);
                        data.then((dataa) {
                          print("sucessfully  ${dataa.id}");
                        });
                        _notesController.clear();
                      }
                    },
                    child: const Text("Submit")),
                const Wspace(),
                ElevatedButton(
                    // style: ButtonStyle(
                    // backgroundColor:
                    // Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      setState(() {
                        _notesController.clear();
                      });
                    },
                    child: const Text("Clear")),
              ]),
              const Hspace(),
              Text("${firestoreService.getNotes1()}"),
              StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    // if (snapshot.hasData) {
                    List data = snapshot.data!.docs;
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 4 / 2.5, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = data[index];
                        String docId = document.id;
                        dynamic dataa = document.data();
                        String? notes = dataa['notes'];
                        // String? texts = dataa['text'];

                        return Card(
                          child: Center(
                            child: GridTile(
                              header: Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () => openDialogBox(docId),
                                      icon: const Icon(Icons.delete))),
                              footer: Container(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  )),
                              child: Center(
                                child: Text(notes ?? ""),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // }
                  }
                },
              ),
              const Hspace(),
              Text(_notesController.text)
            ],
          ))),
    );
  }

  openDialogBox(String docId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Are you sure"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    firestoreService.delete(docId: docId);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"))
            ],
          );
        });
  }
}

class Wspace extends StatelessWidget {
  const Wspace({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(width: 20);
}

class Hspace extends StatelessWidget {
  const Hspace({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(height: 20);
}
