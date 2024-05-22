import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dateAsStringYMD {
    return DateFormat('y年M月d日').format(this);
  }

  String get dateAsStringHHMM {
    return DateFormat('HH:mm').format(this);
  }
}
