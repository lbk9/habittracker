import 'package:flhabittracker/pages/habit_screen.dart';
import 'package:flhabittracker/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/animations/page_bounce_transition.dart';
import 'package:flhabittracker/models/habit_model.dart';

class AddHabit extends StatefulWidget {
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          'Add Habit',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.purple
                  ),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey),
                  labelText: 'Habit',
                  focusColor: Colors.purple
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  icon: const Icon(
                    Icons.date_range,
                    color: Colors.grey),
                  labelText: 'Date & Time'
                ),
                keyboardType: TextInputType.datetime,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0, top: 30.0, right: 20.0),
                child: new RaisedButton(
                  color: Colors.purpleAccent,
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: saveAndNavigate,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                ),
              )
            ],
          )
        )
      ),
      );
  }

  Future<void> saveAndNavigate() async {
    StorageService storageService = new StorageService();
    List<Habit> habits = new List<Habit>();
    var habit = new Habit('test1', DateTime.now());
    var habit2 = new Habit('test2', DateTime.now());
    var habit3 = new Habit('test3', DateTime.now());
    habits.add(habit);
    habits.add(habit2);
    habits.add(habit3);
    var habitJson = Habit.convertToJson(habits);
    await storageService.persistAllHabits(habitJson);
    Navigator.pushReplacement(context, CustomPageBounceTransition(widget: Habits(), alignment: Alignment.center));
  }
}
