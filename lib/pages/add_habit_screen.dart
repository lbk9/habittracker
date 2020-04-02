import 'package:flhabittracker/pages/habit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/animations/page_bounce_transition.dart';

class AddHabit extends StatefulWidget {
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.amber
                  ),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white),
                  labelText: 'Habit',
                  focusColor: Colors.amber
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.amber,
                  ),
                  icon: const Icon(
                    Icons.date_range,
                    color: Colors.white),
                  labelText: 'Date & Time'
                ),
                keyboardType: TextInputType.datetime,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              new RaisedButton(
                color: Colors.amber,
                child: const Text(
                  'Confirm'
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, CustomPageBounceTransition(widget: Habits(), alignment: Alignment.center));
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              )
            ],
          )
        )
      ),
      );
  }
}
