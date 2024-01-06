import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';

class SingleNoteScreen extends StatelessWidget {
  const SingleNoteScreen({super.key});
  static const routeName = '/single_note';

  @override
  Widget build(BuildContext context) {
    void deleteNote(int id) async {
      final noteService = NotesService();
      await noteService.deleteNote(id).then((value) =>
          Navigator.pushReplacementNamed(context, '/', arguments: value));
    }

    final note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Single Note'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(note.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(note.description!,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black87)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    deleteNote(note.id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
