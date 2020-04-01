import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/models/habit_model.dart';
import 'package:flhabittracker/pages/add_habit_screen.dart';

class Habits extends StatefulWidget {
  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  List<Habit> habitList =[
    Habit('Yoga', DateTime.now()),
    Habit('Run', DateTime.now()),
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
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Habit Tracker',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[400],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: (){
          Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd, Widget child){
            animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut, reverseCurve: Curves.elasticOut);
            return ScaleTransition(
            alignment: Alignment.bottomRight,
            scale: animation,
            child: child
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd){
            return AddHabit();
          }));
          },
        child: Icon(
          Icons.add,
          color: Colors.black),
      ),
    );
  }
}
