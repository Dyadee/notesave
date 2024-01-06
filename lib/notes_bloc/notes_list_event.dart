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

class NotesListUpdateEvent extends NotesListEvent {
  Note note;
  NotesListUpdateEvent(this.note);
}

class NotesListDeleteEvent extends NotesListEvent {
  Note note;
  NotesListDeleteEvent(this.note);
}
