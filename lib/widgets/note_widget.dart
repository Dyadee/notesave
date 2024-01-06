import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            leading: const Icon(Icons.note),
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
                print('edit note ${note.id} pressed');
              },
            )),
      ),
    );
  }
}
