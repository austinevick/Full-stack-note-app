import 'package:client/common/utils.dart';
import 'package:client/provider/note_bloc.dart';
import 'package:client/provider/note_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'screen/home_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoteBloc()..add(NoteFetched()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          navigatorKey: navigatorkey,
        ));
  }
}
