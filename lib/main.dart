import 'package:flutter/material.dart';
import 'package:flhabittracker/pages/habit_screen.dart';
import 'package:flhabittracker/pages/add_habit_screen.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Habits(),
      '/add': (context) => AddHabit(),
    }
));