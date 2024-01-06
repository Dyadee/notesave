import 'package:notesave/models/note.dart';

abstract class NotesListState {
  List<Note> notesList = [];
  String errorMessage = '';
  NotesListState({required this.notesList, required this.errorMessage});
}

class NotesListInitialState extends NotesListState {
  NotesListInitialState() : super(notesList: [], errorMessage: '');
}

class NotesListLoadingState extends NotesListState {
  NotesListLoadingState() : super(notesList: [], errorMessage: '');
}

class NotesListLoadedState extends NotesListState {
  NotesListLoadedState(List<Note> notes)
      : super(notesList: notes, errorMessage: '');
}

class NotesListAddState extends NotesListState {
  NotesListAddState(List<Note> notes)
      : super(notesList: notes, errorMessage: '');
}

class NotesListDeleteState extends NotesListState {
  NotesListDeleteState(List<Note> notes)
      : super(notesList: notes, errorMessage: '');
}

class NotesListUpdateState extends NotesListState {
  NotesListUpdateState(List<Note> notes)
      : super(notesList: notes, errorMessage: '');
}

class NotesListErrorState extends NotesListState {
  NotesListErrorState(String error) : super(notesList: [], errorMessage: error);
}
