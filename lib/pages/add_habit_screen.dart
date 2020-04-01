import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/models/habit_model.dart';

class AddHabit extends StatefulWidget {
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Add Habit',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Text(
        'Add a habit here',
      )
    );
  }
}
