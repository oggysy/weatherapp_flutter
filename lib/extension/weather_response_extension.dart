import 'package:weatherapp_flutter/extension/date_time_extension.dart';
import 'package:weatherapp_flutter/model/weather_response_data_model.dart';

extension WeatherResponseExtension on WeatherResponse {
  List<Map<String, int>> get timeAndPopList {
    return list.map((data) {
      String time =
          DateTime.fromMillisecondsSinceEpoch(data.dt * 1000).formattedTime;
      int popPercent = (data.pop * 100).toInt();
      return {time: popPercent};
    }).toList();
  }
}
