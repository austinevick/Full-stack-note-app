import 'package:client/provider/note_bloc.dart';
import 'package:client/provider/note_state.dart';
import 'package:client/screen/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'All notes',
                  style: TextStyle(fontSize: 25),
                ),
                state is NoteLoaded
                    ? Text("${state.notes.length} Notes")
                    : const SizedBox.shrink(),
                const SizedBox(height: 35),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ],
                ),
                const SizedBox(height: 20),
                buildNoteList(state)
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AddNoteScreen())),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  Widget buildNoteList(NoteState state) {
    if (state is NoteLoaded) {
      return Column(
          children: List.generate(
              state.notes.reversed.toList().length,
              (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.white,
                      onPressed: () =>
                          Navigator.of(navigatorkey.currentContext!).push(
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      AddNoteScreen(note: state.notes[i]))),
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 8, color: Colors.grey.shade500),
                                const SizedBox(width: 16),
                                Text(
                                  state.notes[i].title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Text(
                                fromDateTime(state.notes[i].createdAt),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey.shade500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));
    } else {
      return const Center(
        child: SizedBox.shrink(),
      );
    }
  }
}

String fromDateTime(DateTime dateTime) {
  final diffInDays = dateTime.difference(DateTime.now());
  if (diffInDays.inHours >= 24) {
    return 'Yesterday';
  }
  return TimeOfDay.fromDateTime(dateTime).format(navigatorkey.currentContext!);
}
