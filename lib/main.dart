import 'package:flutter/material.dart';
import 'package:flhabittracker/pages/habit_screen.dart';
import 'package:flhabittracker/pages/add_habit_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new Habits(),
    routes: <String, WidgetBuilder> {
      '/app': (BuildContext context) => new Habits(),
      '/app/add': (BuildContext context) => new AddHabit()
    },
  ));
}