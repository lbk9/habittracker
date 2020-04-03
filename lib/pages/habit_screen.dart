import 'package:flhabittracker/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/models/habit_model.dart';
import 'package:flhabittracker/pages/add_habit_screen.dart';
import 'package:flhabittracker/animations/page_bounce_transition.dart';

class Habits extends StatefulWidget {
  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  List<Habit> habitList =[
    Habit('Yoga', DateTime.now()),
    Habit('Run', DateTime.now()),
    Habit('Cycle', DateTime.now()),
    Habit('Home workout', DateTime.now()),
    Habit('Water plants', DateTime.now())
  ];

  void incrementStreak(int index){
    setState(() {
      habitList[index].streak++;
    });
  }

  void addHabit(Habit habit){
    var newHabit = new Habit(habit.title, habit.latestEntry);
    habitList.add(newHabit);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          'Habit Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                color: Colors.purpleAccent,
                onPressed: () {
                  StorageService storageService = new StorageService();
                  var jsonList = storageService.readAllHabits();
                },
                child: const Text(
                  'Load Habits',
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  StorageService storageService = new StorageService();
                  storageService.clearFileContents();
                },
                child: const Text(
                  'Clear Habits',
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
                itemCount: habitList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey[100],
                    child: ListTile(
                      title: Text(habitList[index].title),
                      subtitle: Text('You last done this on ${habitList[index].latestEntryAsDate}'),
                      trailing: Text('${habitList[index].streak}'),
                      onTap: (){
                        incrementStreak(index);
                      },
                    ),
                  );
                },
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: (){
          Navigator.pushReplacement(context, CustomPageBounceTransition(widget: AddHabit(), alignment: Alignment.bottomRight));
          },
        child: Icon(
          Icons.add,
          color: Colors.white),
      ),
    );
  }
}
