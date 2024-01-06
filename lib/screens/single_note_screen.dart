import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';

class SingleNoteScreen extends StatelessWidget {
  const SingleNoteScreen({super.key});
  static const routeName = '/single_note';

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Single Note'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(note.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black)),
            ),
            Text(note.description!,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
