import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/screens/edit_note_screen.dart';
import 'package:notesave/screens/single_note_screen.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, SingleNoteScreen.routeName,
                  arguments: note);
            },
            leading: const Icon(
              Icons.description,
              size: 40,
            ),
            title: Text(note.title!,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black)),
            subtitle: Text(note.description!,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black87)),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, EditNoteScreen.routeName,
                    arguments: note);
              },
            )),
      ),
    );
  }
}
