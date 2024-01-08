import 'dart:convert';

import 'package:flutter/material.dart';
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
        List<Note> notesList = [];
        final cachedData = await sharedPreferencesService.getDataIfNotExpired();

        if (cachedData != null) {
          notesList = List<Note>.from(
              json.decode(cachedData).map((i) => Note.fromJson(i)));
        } else {
          ApiResponse responseNotesList = await _notesService.getAllNotesList();
          if (responseNotesList.data is List<Note>) {
            notesList = responseNotesList.data;
          }
        }
        emit.call(NotesListLoadedState(notesList));
      } catch (e) {
        emit.call(NotesListErrorState(e.toString()));
      }
    });

    on<NotesListAddEvent>((event, emit) async {
      try {
        ApiResponse responseSingleNote =
            await _notesService.postNote(event.note);
        final noteAdded = Note.fromJson(responseSingleNote.data);
        List<Note> notesList = [];
        final cachedData = await sharedPreferencesService.getDataIfNotExpired();
        if (cachedData != null) {
          notesList = List<Note>.from(
              json.decode(cachedData).map((i) => Note.fromJson(i)));
          notesList.removeWhere((note) => note.id! == noteAdded.id!);
          notesList.add(noteAdded);
          await sharedPreferencesService.saveDataWithExpiration(
              jsonEncode(notesList), const Duration(days: 7));
        } else {
          ApiResponse responseNotesList = await _notesService.getAllNotesList();
          if (responseNotesList.data is List<Note>) {
            notesList = responseNotesList.data;
          }
        }
        emit.call(NotesListAddState(notesList));
      } catch (e) {
        emit.call(
            NotesListErrorState("notesList Add Event Catch: ${e.toString()}"));
      }
    });

    on<NotesListUpdateEvent>((event, emit) async {
      try {
        ApiResponse responseSingleNote =
            await _notesService.patchNote(event.note);
        final noteUpdated = Note.fromJson(responseSingleNote.data);
        List<Note> notesList = [];
        final cachedData = await sharedPreferencesService.getDataIfNotExpired();
        if (cachedData != null) {
          notesList = List<Note>.from(
              json.decode(cachedData).map((i) => Note.fromJson(i)));
          notesList.removeWhere((note) => note.id! == noteUpdated.id!);
          notesList.add(noteUpdated);
          await sharedPreferencesService.saveDataWithExpiration(
              jsonEncode(notesList), const Duration(days: 7));
        } else {
          ApiResponse responseNotesList = await _notesService.getAllNotesList();
          if (responseNotesList.data is List<Note>) {
            notesList = responseNotesList.data;
          }
        }
        emit.call(NotesListUpdateState(notesList));
      } catch (e) {
        emit.call(NotesListErrorState(
            "notesList Update Event Catch: ${e.toString()}"));
      }
    });

    on<NotesListDeleteEvent>((event, emit) async {
      try {
        ApiResponse responseSingleNote =
            await _notesService.deleteNote(event.note.id!);

        debugPrint('responseSingleNote.data: ${responseSingleNote.data}');

        Note noteDeleted = responseSingleNote.data;

        List<Note> notesList = [];
        final cachedData = await sharedPreferencesService.getDataIfNotExpired();
        if (cachedData != null) {
          notesList = List<Note>.from(
              json.decode(cachedData).map((i) => Note.fromJson(i)));
          notesList.removeWhere((note) => note.id! == noteDeleted.id!);
          await sharedPreferencesService.saveDataWithExpiration(
              jsonEncode(notesList), const Duration(days: 7));
        } else {
          ApiResponse responseNotesList = await _notesService.getAllNotesList();
          if (responseNotesList.data is List<Note>) {
            notesList = responseNotesList.data;
          }
        }
        emit.call(NotesListDeleteState(notesList));
      } catch (e) {
        emit.call(NotesListErrorState(
            "notesList Delete Event Catch: ${e.toString()}"));
      }
    });
  }
}
