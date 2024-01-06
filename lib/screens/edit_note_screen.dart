import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  static const routeName = '/edit_note';

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Note;
    print(args.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Edit Note'),
      ),
      body: const Center(
        child: Text('Edit Note'),
      ),
    );
  }
}
