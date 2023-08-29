import 'dart:io';

import 'package:client/provider/note_event.dart';
import 'package:client/provider/note_state.dart';
import 'package:client/repository/note_remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final repository = NoteRemoteRepository();
  NoteBloc() : super(NoteInitial()) {
    on<NoteFetched>((event, emit) => fetchNote(event, emit));
    on<NoteAdded>((event, emit) => addNote(event, emit));
    on<NoteUpdate>((event, emit) => updateNote(event, emit));
    on<NoteDeleted>((event, emit) => deleteNote(event, emit));
  }

  void fetchNote(NoteFetched event, Emitter<NoteState> emit) async {
    try {
      final response = await repository.getNotes();
      emit(NoteLoaded(notes: response));
    } on SocketException catch (_) {
      final response = await repository.getNotesFromDisk();
      emit(NoteLoaded(notes: response));
    }
  }

  void addNote(NoteAdded event, Emitter<NoteState> emit) async {
    try {
      await repository.createNotes(event.model);
    } on SocketException catch (_) {
    } catch (_) {
      emit(NoteError('Something went wrong'));
    }
  }

  void updateNote(NoteUpdate event, Emitter<NoteState> emit) async {
    try {
      await repository.updateNotes(event.model);
    } on SocketException catch (_) {
    } catch (_) {
      emit(NoteError('Something went wrong'));
    }
  }

  void deleteNote(NoteDeleted event, Emitter<NoteState> emit) async {
    try {
      await repository.deleteNotes(event.id);
    } on SocketException catch (_) {
    } catch (_) {
      emit(NoteError('Something went wrong'));
    }
  }
}
