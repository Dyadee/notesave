import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';

class NoteForm extends StatefulWidget {
  final Note? note;
  const NoteForm({super.key, this.note});

  @override
  NoteFormState createState() {
    return NoteFormState();
  }
}

class NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      noteTitle.text = widget.note!.title!;
      noteDescription.text = widget.note!.description!;
    }
  }

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
                  final noteService = NotesService();
                  if (widget.note != null) {
                    Note newNote = Note(
                        title: noteTitle.text,
                        description: noteDescription.text,
                        id: widget.note!.id!);
                    await noteService.patchNote(newNote).then((apiresponse) =>
                        Navigator.pushReplacementNamed(context, '/',
                            arguments: apiresponse));
                  } else {
                    Note note = Note(
                        title: noteTitle.text,
                        description: noteDescription.text);
                    await noteService.postNote(note).then((apiresponse) =>
                        Navigator.pushReplacementNamed(context, '/',
                            arguments: apiresponse));
                  }
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
