import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //ambil notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // create notes
  Future<void> addNote(String note){
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now()
    });
  }

  // read notes from firestore
  Stream<QuerySnapshot> getNotesStream(){
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  // update notes from firestore
  Future<void> updateNote(String docID, String newNote){
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // delete notes from firestore
  Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
  }

}