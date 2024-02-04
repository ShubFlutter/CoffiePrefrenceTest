import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference note =
      FirebaseFirestore.instance.collection("notes");

  Future addNotes(String notes) {
    return note.add({"notes": notes, "timespamt": Timestamp.now()});
  }

  Stream<QuerySnapshot> getNotes() {
    final notestream = note.orderBy("timespamt", descending: true).snapshots();
    return notestream;
  }

  Future<DocumentSnapshot<Object?>> getNotes1() async {
    final notestream = await note.doc("ybtVYVFodRn4McZ65x4J").get();
    return notestream;
  }

  delete({required String? docId}) {
    return note.doc(docId).delete().then((value) => "Deleted Successfully");
  }
}
