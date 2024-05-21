import 'package:intl/intl.dart';

extension TimeStampExtension on int {
  String toHourMinuteString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat('HH:mm').format(date);
  }

  String toMonthDayString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat('MM月dd日').format(date);
  }
}
