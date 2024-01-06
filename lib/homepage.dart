import 'package:flutter/material.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _counter = 0;

  void getAllNotes() async {
    final noteService = NotesService();
    final response = await noteService.getAllNotesList();
    print('get response: ${response.responseData}');
  }

  void addNote() async {
    Note note =
        const Note(title: 'Second Note', description: 'Second Description');
    final noteService = NotesService();
    final response = await noteService.postNote(note);
    print('post response: ${response.responseData}');
  }

  void deleteNote(int id) async {
    final noteService = NotesService();
    final response = await noteService.deleteNote(id);
    print('delete response: ${response.responseData}');
  }

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              deleteNote(2);
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: addNote,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
