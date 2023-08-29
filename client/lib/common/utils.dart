import 'package:flutter/material.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void showSnackbar(String text) =>
    ScaffoldMessenger.of(navigatorkey.currentContext!)
        .showSnackBar(SnackBar(content: Text(text)));
