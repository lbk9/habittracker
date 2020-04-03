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

  Future<File> persistAllHabits(String habits) async {
    final file = await _localFile;
    print('$habits, $file');
    // needs to updated to correctly store new habits without overwriting previous ones
    return file.writeAsString('${await file.readAsString()},$habits');
  }

  Future<List<Habit>> readAllHabits() async {
    var habitList = new List<Habit>();
    try{
      final file = await _localFile;
      var responseJson = json.decode(await file.readAsString()) as List;
      List<Habit> habits = (responseJson.map((p) => Habit.fromJson(p)).toList());
      print(habits.length);
      return habits;
    } catch (e){
      print(e.toString());
      return habitList;
    }
  }

  Future<void> clearFileContents() async {
  final file = await _localFile;
  file.writeAsString('');
  print(await readAllHabits());
}


}