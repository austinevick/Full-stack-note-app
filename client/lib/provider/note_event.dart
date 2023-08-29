import 'package:client/model/note_model.dart';
import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {}

class NoteFetched extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class NoteAdded extends NoteEvent {
  final NoteModel model;

  NoteAdded(this.model);
  @override
  List<Object?> get props => [model];
}

class NoteUpdate extends NoteEvent {
  final NoteModel model;

  NoteUpdate(this.model);

  @override
  List<Object?> get props => [model];
}

class NoteDeleted extends NoteEvent {
  final int id;

  NoteDeleted(this.id);
  @override
  List<Object?> get props => [id];
}
