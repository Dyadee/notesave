import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/widgets/note_form.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  static const routeName = '/edit_note';

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Edit Note'),
      ),
      body: Center(
        child: NoteForm(
          note: note,
        ),
      ),
    );
  }
}
