import 'package:intl/intl.dart';

class TimeHelper {
  static DateTime format() {
    final dateNowFormat = DateTime.now();
    final dateFormat = DateFormat("y/M/d");
    final timeSpecificFormat = "11:00:00";
    final completeTimeFormat = DateFormat("y/M/d H:m:s");

    final todayDate = dateFormat.format(dateNowFormat);
    final todayDateAndTime = "$todayDate $timeSpecificFormat";
    var resultToday = completeTimeFormat.parseStrict(todayDateAndTime);

    var tomorrowFormat = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateFormat.format(tomorrowFormat);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecificFormat";
    var resultTomorrow = completeTimeFormat.parseStrict(tomorrowDateAndTime);

    return dateNowFormat.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}