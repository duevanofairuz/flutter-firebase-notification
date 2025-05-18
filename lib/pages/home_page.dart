import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();

  TextEditingController textController = TextEditingController(text: "");

  // dialog box (alert dialog) to add a note
  void openNoteBox(String? docID){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                //addnote menggunakan fungsi di objek FirestoreService
                if (docID == null){
                  firestoreService.addNote(textController.text);
                }
                else {
                  firestoreService.updateNote(docID, textController.text);
                }
                // clear controller untuk penggunaan berikutnya
                textController.clear();
                // close alert dialog
                Navigator.pop(context);
              },
              child: Text("Save")
            )
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halo Ngab"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(null),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot){
          //get data if there is data (get all the docs)
          if (snapshot.hasData){
            List notesList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                //get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () => openNoteBox(docID= docID),
                          icon: Icon(Icons.edit)
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteNote(docID),
                        icon: Icon(Icons.delete)
                      ),
                    ],
                  )
                );
              }
            );
          }
          else{
            return const Text("No notes yet...");
          }
        }
      ),
    );
  }
}
