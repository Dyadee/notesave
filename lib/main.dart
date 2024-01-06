import 'package:flutter/material.dart';
import 'package:notesave/homepage.dart';
import 'package:notesave/screens/add_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Save',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Note Save'),
        '/add_note': (context) => const AddNoteScreen(),
      },
    );
  }
}
