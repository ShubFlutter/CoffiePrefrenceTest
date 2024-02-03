import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference note =
      FirebaseFirestore.instance.collection("notes");

  Future addNotes(String notes) {
    return note.add({"notes": notes, "timespamt": Timestamp.now()});
  }

  Stream<QuerySnapshot> getNotes() {
    final notestream = note.orderBy("timestamp", descending: true).snapshots();
    return notestream;
  }
}
