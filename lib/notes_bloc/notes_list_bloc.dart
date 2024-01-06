import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/notes_bloc/notes_list_event.dart';
import 'package:notesave/notes_bloc/notes_list_state.dart';
import 'package:notesave/response_model/api_response.dart';
import 'package:notesave/service/notes_service.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  final NotesService _notesService = NotesService();
  NotesListBloc() : super(NotesListInitialState()) {
    on<NotesListGetAllEvent>((event, emit) async {
      emit.call(NotesListLoadingState());
      try {
        ApiResponse response = await _notesService.getAllNotesList();
        if (response.data is List<Note>) {
          emit.call(NotesListLoadedState(response.data));
        } else {
          emit.call(NotesListErrorState(response.data.toString()));
        }
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });
  }
}
