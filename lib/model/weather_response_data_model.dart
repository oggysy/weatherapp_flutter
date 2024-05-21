// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
part 'weather_response_data_model.freezed.dart';
part 'weather_response_data_model.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const WeatherResponse._();
  const factory WeatherResponse({
    required List<WeatherData> list,
    required City city,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  List<Map<String, int>> extractTimeAndPop() {
    return list.map((data) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);
      String time = DateFormat('HH:mm').format(date);
      int popPercent = (data.pop * 100).toInt();
      return {time: popPercent};
    }).toList();
  }
}

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required int dt,
    required WeatherItem main,
    required List<Weather> weather,
    required double pop,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}

@freezed
class WeatherItem with _$WeatherItem {
  const factory WeatherItem({
    required double temp_min,
    required double temp_max,
    required int humidity,
  }) = _WeatherItem;

  factory WeatherItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromJson(json);
}

@freezed
class Weather with _$Weather {
  const factory Weather({
    required String icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class City with _$City {
  const factory City({
    required String name,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
