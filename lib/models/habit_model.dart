import 'package:intl/intl.dart';

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
}