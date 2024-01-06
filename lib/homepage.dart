import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesave/constants/constants.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/service/notes_service.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void getAllNotes() async {
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}');
    print('url: $url');

    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    print('${response.statusCode}: ${response.body}');
    final notes = List<Note>.from(
        json.decode(response.body).map((i) => Note.fromJson(i)));
    print('notes: $notes');
  }

  @override
  void initState() {
    // TODO: implement initState
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
