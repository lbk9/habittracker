import 'package:intl/intl.dart';
import 'dart:convert';

Habit habitFromJson(String str) => Habit.fromJson(jsonDecode(str));

class Habit{
  final dateFormatter = DateFormat('dd/MM/yyyy');
  String title;
  DateTime datePerformed;
  DateTime dateAdded;
  String datePerformedAsDate;
  int streak;

  Habit(String title, DateTime datePerformed, DateTime dateAdded, int streak)
  {
    this.title = title;
    this.datePerformed = datePerformed;
    this.dateAdded = dateAdded;
    this.datePerformedAsDate = dateFormatter.format(datePerformed);
    this.streak = streak;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "datePerformed": this.datePerformed.toString(),
      "dateAdded":this.dateAdded.toString(),
      "streak": this.streak.toString()
    };
  }

  static String convertToJson(List<Habit> habits){
    return jsonEncode(habits.map((i) => i.toJson()).toList()).toString();
  }
  
  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    json['title'].toString(),
    DateTime.parse(json['datePerformed']),
    DateTime.parse(json['dateAdded']),
    int.parse(json['streak'])
  );
}