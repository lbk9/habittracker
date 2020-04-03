import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flhabittracker/models/habit_model.dart';

class StorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/habitdata.json');
  }

  StorageService();

  Future<File> persistHabit(Habit habit) async {
    final file = await _localFile;
    var habitJson = jsonEncode(habit);
    return file.writeAsString(habitJson);
  }

  Future<File> persistAllHabits(List<Habit> habits) async {
    final file = await _localFile;
    var habitList = jsonEncode(habits);
    print(habitList);
    return file.writeAsString(habitList);
  }

  Future<List<Habit>> readAllHabits() async {
    var habitList = new List<Habit>();
    try{
      final file = await _localFile;
      var contents = await file.readAsString();
      return Habit.fromJsonList(contents);
    } catch (e){
      print(e.toString());
      return habitList;
    }
  }

}