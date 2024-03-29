import 'package:flutter/material.dart';
import 'package:notesave/widgets/note_form.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Add New Note'),
      ),
      body: const Center(
        child: NoteForm(),
      ),
    );
  }
}
