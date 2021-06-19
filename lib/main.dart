import 'package:flutter/material.dart';
import 'package:flutter_world_clock/pages/home.dart';
import 'package:flutter_world_clock/pages/choose_location.dart';
import 'package:flutter_world_clock/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation()
    },
  ));
}

