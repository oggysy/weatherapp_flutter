import 'package:intl/intl.dart';
import 'package:weatherapp_flutter/model/weather_response_data_model.dart';

extension WeatherResponseExtension on WeatherResponse {
  List<Map<String, int>> get timeAndPopList {
    return list.map((data) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);
      String time = DateFormat('HH:mm').format(date);
      int popPercent = (data.pop * 100).toInt();
      return {time: popPercent};
    }).toList();
  }
}
