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
  StorageService storageService = new StorageService();

  Future<List<Habit>> getHabits() async {
    return storageService.readAllHabits();
  }

  void incrementStreak(int index){
    setState(() {
      StorageService storageService = new StorageService();
      storageService.clearFileContents();
    });
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
            child: FutureBuilder(
              future: getHabits(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  if(snapshot.data.length == 0) {
                      return Center(
                          child: Text(
                              'No items'
                          )
                      );
                    } else{
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          color: Colors.blueGrey[100],
                          child: ListTile(
                            title: Text(snapshot.data[index].title),
                            subtitle: Text('You last done this on ${snapshot.data[index].latestEntryAsDate}'),
                            trailing: Text('${snapshot.data[index].streak}'),
                            onTap: (){
                              // need to save to JSON and reload
                            },
                          ),
                        );
                      },
                    );
                  }
                  } else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        strokeWidth: 8.0,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                      ),
                      Text(
                        'Gathering habits...'
                      ),
                    ],
                  );
                }
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
