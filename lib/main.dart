import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesave/notes_bloc/notes_list_bloc.dart';
import 'package:notesave/screens/edit_note_screen.dart';
import 'package:notesave/screens/homepage.dart';
import 'package:notesave/screens/add_note_screen.dart';
import 'package:notesave/screens/single_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesListBloc(),
      child: MaterialApp(
        title: 'Note Save',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(title: 'Note Save'),
          '/add_note': (context) => const AddNoteScreen(),
          EditNoteScreen.routeName: (context) => const EditNoteScreen(),
          SingleNoteScreen.routeName: (context) => const SingleNoteScreen(),
        },
      ),
    );
  }
}
