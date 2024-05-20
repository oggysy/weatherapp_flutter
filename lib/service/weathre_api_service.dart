import 'package:dio/dio.dart';
import 'package:weatherapp_flutter/model/weather_response_data_model.dart';

class WeathreAPIService {
  static final WeathreAPIService instance =
      WeathreAPIService._internal(dio: Dio());

  const WeathreAPIService._internal({required this.dio});

  final Dio dio;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/forecast?r";
  final String _apiKey = "5dfc577c1d7d94e9e23a00431582f1ac";
  final String _units = 'metric';
  final String _count = '8';
  final String _lang = 'ja';

  Future<WeatherResponse> fetchWeatherFromCity({required String city}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        _baseUrl,
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'count': _count,
          'units': _units,
          'lang': _lang,
        },
      );
      if (response.statusCode == 200) {
        final data = WeatherResponse.fromJson(response.data);
        print(data.toString());
        return data;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error fetching weather data: $e');
    }
  }
}
