import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/notes_bloc/notes_list_bloc.dart';
import 'package:notesave/notes_bloc/notes_list_event.dart';
import 'package:notesave/notes_bloc/notes_list_state.dart';
import 'package:notesave/widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  static const routeName = '/';

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes;

  @override
  Widget build(BuildContext context) {
    context.read<NotesListBloc>().add(NotesListGetAllEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          BlocBuilder<NotesListBloc, NotesListState>(builder: (context, state) {
        if (state is NotesListLoadedState) {
          notes = state.notesList;
          return ListView(
            children: [
              ...state.notesList.map((note) => NoteWidget(note: note))
            ],
          );
        } else {
          return Container(
            color: Colors.amber.shade300,
            width: double.infinity,
            height: double.infinity,
          );
        }
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_note');
            },
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
