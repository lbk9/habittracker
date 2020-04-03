import 'package:intl/intl.dart';
import 'dart:convert';

class Habit{
  final dateFormatter = DateFormat('dd/MM/yyyy');
  String title;
  DateTime latestEntry;
  String latestEntryAsDate;
  int streak;

  Habit(String title, DateTime latestEntry)
  {
    this.title = title;
    this.latestEntry = latestEntry;
    this.latestEntryAsDate = dateFormatter.format(latestEntry);
    this.streak = getStreak(latestEntry);
  }

  int getStreak(DateTime addedDate)
  {
    var streak = 0;
    if(addedDate.day == DateTime.now().day)
      {
        streak = 1;
      }
    else
      {
        streak = 1;
      }
    return streak;
  }

  static Habit fromJsonMap(Map<String, dynamic> json){
    String title = json['title'];
    DateTime latestEntry = DateTime.parse(json['latestEntry']);
    Habit h = new Habit(title, latestEntry);
    return h;
  }

  static List<Habit> fromJsonList(String json){
    Map<String, dynamic> decodedMap = jsonDecode(json);
    List<dynamic> habitDynamicList = decodedMap['habits'];
    List<Habit> habits = new List<Habit>();
    habitDynamicList.forEach((f) {
      Habit h = fromJsonMap(f);
      habits.add(h);
    });

    return habits;
  }
}