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

    var tommorowFormat = resultToday.add(Duration(days: 1));
    final tommorowDate = dateFormat.format(tommorowFormat);
    final tommorowDateAndTime = "$tommorowDate, $timeSpecificFormat";
    var resultTommorow = completeTimeFormat.parseStrict(tommorowDateAndTime);

    return dateNowFormat.isAfter(resultToday) ? resultTommorow : resultToday;
  }
}