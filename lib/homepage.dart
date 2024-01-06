import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';
import 'package:notesave/widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  void getAllNotes() async {
    final noteService = NotesService();
    final response = await noteService.getAllNotesList();
    if (response.data is List<Note>) {
      setState(() {
        notes = [...response.data];
      });
    }
    print('get response: ${response.data}');
  }

  void addNote() async {
    Note note =
        const Note(title: 'Second Note', description: 'Second Description');
    final noteService = NotesService();
    final response = await noteService.postNote(note);
    print('post response: ${response.data}');
  }

  void deleteNote(int id) async {
    final noteService = NotesService();
    final response = await noteService.deleteNote(id);
    print('delete response: ${response.data}');
  }

  void updateNote() async {
    Note note = const Note(
        title: 'Updated Note', description: 'Updated Description', id: 3);
    final noteService = NotesService();
    final response = await noteService.patchNote(note);
    print('update response: ${response.data}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [...notes.map((note) => NoteWidget(note: note))],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              deleteNote(2);
            },
            tooltip: 'Delete Note',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: addNote,
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: updateNote,
            tooltip: 'Update Note',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
