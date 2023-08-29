import 'package:client/model/note_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class NoteState extends Equatable {}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoaded extends NoteState {
  final List<NoteListResponseData> notes;

  NoteLoaded({required this.notes});
  @override
  List<Object?> get props => [notes];
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
  @override
  List<Object?> get props => [message];
}
