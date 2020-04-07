import 'package:intl/intl.dart';
import 'dart:convert';

Habit habitFromJson(String str) => Habit.fromJson(jsonDecode(str));

class Habit{
  final dateFormatter = DateFormat('dd/MM/yyyy');
  String title;
  DateTime latestEntry;
  String latestEntryAsDate;
  int streak;

  Habit(String title, DateTime latestEntry, int streak)
  {
    this.title = title;
    this.latestEntry = latestEntry;
    this.latestEntryAsDate = dateFormatter.format(latestEntry);
    this.streak = streak;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "latestEntry": this.latestEntry.toString(),
      "streak": this.streak.toString()
    };
  }

  static String convertToJson(List<Habit> habits){
    return jsonEncode(habits.map((i) => i.toJson()).toList()).toString();
  }
  
  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    json['title'].toString(),
    DateTime.parse(json['latestEntry']),
    int.parse(json['streak'])
  );
}