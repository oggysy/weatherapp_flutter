import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

extension TimeOfDayExtension on TimeOfDay {
  tz.TZDateTime toTZDateTime() {
    final location = tz.getLocation('Asia/Tokyo');
    final now = tz.TZDateTime.now(location);
    return tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }

  String toJapaneseString() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    return '$hours時$minutes分';
  }
}
