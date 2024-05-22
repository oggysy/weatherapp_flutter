import 'package:dio/dio.dart';
import 'package:weatherapp_flutter/model/weather_response_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeathreAPIService {
  static const WeathreAPIService instance = WeathreAPIService._internal();

  const WeathreAPIService._internal();

  final String _baseUrl = "https://api.openweathermap.org/data/2.5/forecast?r";
  final String _units = 'metric';
  final String _count = '8';
  final String _lang = 'ja';

  Future<WeatherResponse> _fetchWeatherData(
      Map<String, dynamic> queryParameters) async {
    final dio = Dio();
    final String apiKey = dotenv.get('API_KEY');
    queryParameters['appid'] = apiKey;
    queryParameters['cnt'] = _count;
    queryParameters['units'] = _units;
    queryParameters['lang'] = _lang;

    try {
      final response = await dio.get(
        _baseUrl,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final data = WeatherResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error fetching weather data: $e');
    }
  }

  Future<WeatherResponse> fetchWeatherFromCity({required String city}) {
    return _fetchWeatherData({'q': city});
  }

  Future<WeatherResponse> fetchWeatherFromLocation(
      {required double lat, required double lon}) {
    return _fetchWeatherData({'lat': lat, 'lon': lon});
  }
}
