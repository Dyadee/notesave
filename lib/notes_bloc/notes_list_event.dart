import 'package:notesave/models/note.dart';

abstract class NotesListEvent {
  List<Note>? notes;
  NotesListEvent({this.notes});
}

class NotesListGetAllEvent extends NotesListEvent {}

class NotesListAddEvent extends NotesListEvent {
  Note note;
  NotesListAddEvent(this.note);
}

class NotesListDeleteEvent extends NotesListEvent {}

class NotesListUpdateEvent extends NotesListEvent {}
