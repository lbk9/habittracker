import 'package:flhabittracker/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flhabittracker/models/habit_model.dart';
import 'package:flhabittracker/pages/add_habit_screen.dart';
import 'package:flhabittracker/animations/page_bounce_transition.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Habits extends StatefulWidget {
  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  StorageService storageService = new StorageService();
  ScrollController scrollController;
  bool dialVisible = true;

  Future<List<Habit>> getHabits() async {
    return storageService.readAllHabits();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection == ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        title: Text(
          'Trakr',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
              future: getHabits(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  if(snapshot.data.length == 0) {
                      return Center(
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/emptylist.png'),
                                fit: BoxFit.scaleDown,
                              )
                            ),
                        ),
                      );
                    } else{
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          color: Colors.blueGrey[100],
                          child: ListTile(
                            title: Text(snapshot.data[index].title),
                            subtitle: Text('Last performed on ${snapshot.data[index].datePerformedAsDate}'),
                            trailing: Text('${snapshot.data[index].streak}'),
                            onTap: (){
                              var listItem = snapshot.data[index];
                              var incrementedStreak = listItem.streak++;
                              snapshot.data[index].title = 'test';
                            },
                          ),
                        );
                      },
                    );
                  }
                  } else{
                  return Center(
                    child: Column(
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
                    ),
                  );
                }
              },
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.purple[500],
        visible: dialVisible,
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.purpleAccent,
            label: 'Add Habit',
              labelStyle: TextStyle(
                  fontSize: 18.0
              ),
            onTap: (){
              Navigator.pushReplacement(context, CustomPageBounceTransition(widget: AddHabit(), alignment: Alignment.bottomRight));
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.delete_forever),
            backgroundColor: Colors.red,
            label: 'Delete All',
            labelStyle: TextStyle(
              fontSize: 18.0
            ),
            onTap: () {
              storageService.clearFileContents();
              setState(() {});
            }
          )
        ],
      ),
    );
  }
}
