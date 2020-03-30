import 'package:flutter/material.dart';
import 'package:flhabittracker/pages/habit_screen.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Habits(),
    }
));