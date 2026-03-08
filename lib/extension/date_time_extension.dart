/*import 'package:calendar_time/calendar_time.dart';

extension DateTimeonUtil on DateTime {
  bool isSameDayWith(DateTime time) {
    return this.day == time.day &&
        this.month == time.month &&
        this.year == time.year;
  }

  String toHuman() {
    debugPrint("yes " + CalendarTime(this).format("yyyy-MM-dd HH:mm"));
    var calendarTime = CalendarTime(this);

    if (calendarTime.isToday) {
      return calendarTime.toHuman;
    } else if (calendarTime.isTomorrow) {
      return calendarTime.toHuman;
    } else if (calendarTime.isYesterday) {
      return calendarTime.toHuman;
    }

    return calendarTime.format("yyyy-MM-dd");
  }

  String removeTime() {
    return "${this.year}-${this.month}-${this.day}";
  }

  String removeDate() {
    return "${this.hour}:${this.minute}";
  }
}
*/