import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesave/cache/shared_preferences_service.dart';
import 'package:notesave/models/note.dart';
import 'package:notesave/notes_bloc/notes_list_event.dart';
import 'package:notesave/notes_bloc/notes_list_state.dart';
import 'package:notesave/response_model/api_response.dart';
import 'package:notesave/service/notes_service.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  final NotesService _notesService = NotesService();
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  NotesListBloc() : super(NotesListInitialState()) {
    on<NotesListGetAllEvent>((event, emit) async {
      emit.call(NotesListLoadingState());
      try {
        ApiResponse response = await _notesService.getAllNotesList();
        if (response.data is List<Note>) {
          final cachedData =
              await sharedPreferencesService.getDataIfNotExpired();
          if (cachedData != null) {
            final notesList = List<Note>.from(
                json.decode(cachedData).map((i) => Note.fromJson(i)));
            emit.call(NotesListLoadedState(notesList));
          } else {
            emit.call(NotesListLoadedState(response.data));
          }
        } else {
          emit.call(NotesListErrorState(response.data.toString()));
        }
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });

    on<NotesListAddEvent>((event, emit) async {
      try {
        ApiResponse response = await _notesService.postNote(event.note);
        if (response.data is Note) {
          ApiResponse response = await _notesService.getAllNotesList();
          if (response.data is List<Note>) {
            final cachedData =
                await sharedPreferencesService.getDataIfNotExpired();
            if (cachedData != null) {
              final notesList = List<Note>.from(
                  json.decode(cachedData).map((i) => Note.fromJson(i)));
              emit.call(NotesListAddState(notesList));
            } else {
              emit.call(NotesListAddState(response.data));
            }
          } else {
            emit.call(NotesListErrorState(response.data.toString()));
          }
        } else {
          emit.call(NotesListErrorState(response.data.toString()));
        }
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });

    on<NotesListUpdateEvent>((event, emit) async {
      try {
        ApiResponse response = await _notesService.patchNote(event.note);
        if (response.data is Note) {
          ApiResponse response = await _notesService.getAllNotesList();

          if (response.data is List<Note>) {
            final cachedData =
                await sharedPreferencesService.getDataIfNotExpired();
            if (cachedData != null) {
              final notesList = List<Note>.from(
                  json.decode(cachedData).map((i) => Note.fromJson(i)));
              emit.call(NotesListUpdateState(notesList));
            } else {
              emit.call(NotesListUpdateState(response.data));
            }
          } else {
            emit.call(NotesListErrorState(response.data.toString()));
          }
        } else {
          emit.call(NotesListErrorState(response.data.toString()));
        }
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });

    on<NotesListDeleteEvent>((event, emit) async {
      try {
        ApiResponse response = await _notesService.deleteNote(event.note.id!);
        if (response.data is Note) {
          ApiResponse response = await _notesService.getAllNotesList();

          if (response.data is List<Note>) {
            final cachedData =
                await sharedPreferencesService.getDataIfNotExpired();
            if (cachedData != null) {
              final notesList = List<Note>.from(
                  json.decode(cachedData).map((i) => Note.fromJson(i)));
              emit.call(NotesListDeleteState(notesList));
            } else {
              emit.call(NotesListDeleteState(response.data));
            }
          } else {
            emit.call(NotesListErrorState(response.data.toString()));
          }
        } else {
          emit.call(NotesListErrorState(response.data.toString()));
        }
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });
  }
}
