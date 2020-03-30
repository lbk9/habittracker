import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/models/habit_model.dart';

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
          //function
        },
        child: Icon(
          Icons.add,
          color: Colors.black),
      ),
    );
  }
}
