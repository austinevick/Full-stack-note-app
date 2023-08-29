import 'dart:developer';

import 'package:client/common/utils.dart';
import 'package:client/model/note_model.dart';
import 'package:client/provider/note_bloc.dart';
import 'package:client/provider/note_event.dart';
import 'package:client/provider/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/note_list_model.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteListResponseData? note;
  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final title = TextEditingController();
  final content = TextEditingController();
  int id = 0;
  @override
  void initState() {
    if (widget.note == null) return;
    title.text = widget.note!.title;
    id = widget.note!.id;
    content.text = widget.note!.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(id.toString());
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            widget.note == null
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      context
                          .read<NoteBloc>()
                          .add(NoteDeleted(widget.note!.id));
                      Future.delayed(const Duration(seconds: 1), () {
                        context.read<NoteBloc>().add(NoteFetched());
                        Navigator.of(navigatorkey.currentContext!).pop();
                      });
                    },
                    icon: const Icon(Icons.delete_outline)),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                  onPressed: () {
                    final model = NoteModel(
                        id: id,
                        title: title.text.trim(),
                        content: content.text.trim());
                    if (widget.note == null) {
                      context.read<NoteBloc>().add(NoteAdded(model));
                    } else {
                      context.read<NoteBloc>().add(NoteUpdate(model));
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      context.read<NoteBloc>().add(NoteFetched());
                      Navigator.of(navigatorkey.currentContext!).pop();
                    });
                  },
                  icon: const Icon(Icons.check)),
            )
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                TextField(
                  controller: title,
                  style: Theme.of(context).textTheme.titleLarge,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: content,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Notes',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
