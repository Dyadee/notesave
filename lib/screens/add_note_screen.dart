import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';

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
        child: NewNoteForm(),
      ),
    );
  }
}

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key});

  @override
  NewNoteFormState createState() {
    return NewNoteFormState();
  }
}

class NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: noteTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: noteDescription,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Saving Note')),
                  // );

                  Note note = Note(
                      title: noteTitle.text, description: noteDescription.text);
                  final noteService = NotesService();
                  await noteService.postNote(note).then((apiresponse) =>
                      Navigator.pushReplacementNamed(context, '/',
                          arguments: apiresponse));
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
