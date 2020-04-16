import 'package:flhabittracker/pages/habit_screen.dart';
import 'package:flhabittracker/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/animations/page_bounce_transition.dart';
import 'package:flhabittracker/models/habit_model.dart';
import 'package:intl/intl.dart';

class AddHabit extends StatefulWidget {
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  DateTime dateToSend = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  StorageService storageService = new StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
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
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.purple
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purpleAccent, width: 1)
                  ),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey),
                  labelText: 'Habit',
                  focusColor: Colors.purple,
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black
                ),
                controller: titleController,
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: new TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purpleAccent, width: 1)
                    ),
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.grey),
                    labelText: 'Date'
                  ),
                  onTap: (){
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 1)
                    ).then((date) {
                      dateToSend = date;
                      dateController.text = showFormattedDate(date);
                    });
                  },
                  style: TextStyle(
                    color: Colors.black
                  ),
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
                  onPressed: (){
                    persistHabit();
                    Navigator.pushReplacement(context, CustomPageBounceTransition(widget: Habits(), alignment: Alignment.center));
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                ),
              )
            ],
          )
        )
      ),
      );
  }

  String showFormattedDate(DateTime date){
    final dateFormatter = DateFormat('dd/MM/yyyy');
    return dateFormatter.format(date);
  }

  Future<void> persistHabit() async {
    var habit = new Habit(titleController.text, dateToSend, DateTime.now(), 1);
    List<Habit> habits = [habit];

    var habitsFromFile = await storageService.readAllHabits();
    if(habitsFromFile.length >= 1){
      habitsFromFile.forEach((habit) => habits.add(habit));
    }
    var habitJson = Habit.convertToJson(habits);
    await storageService.persistAllHabits(habitJson);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
