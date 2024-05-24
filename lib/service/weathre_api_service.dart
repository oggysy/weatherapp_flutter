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
      try {
        final data = WeatherResponse.fromJson(response.data);
        return data;
      } catch (e) {
        throw Exception('デコード失敗しました');
      }
    } on DioException catch (dioException) {
      final message = _handleErrorMessage(dioException);
      throw Exception(message);
    }
  }

  Future<WeatherResponse> fetchWeatherFromCity({required String city}) {
    return _fetchWeatherData({'q': city});
  }

  Future<WeatherResponse> fetchWeatherFromLocation(
      {required double lat, required double lon}) {
    return _fetchWeatherData({'lat': lat, 'lon': lon});
  }

  String _handleErrorMessage(DioException dioException) {
    if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.sendTimeout ||
        dioException.type == DioExceptionType.receiveTimeout) {
      return 'タイムアウトしました';
    } else if (dioException.type == DioExceptionType.badResponse) {
      final statusCode = dioException.response?.statusCode;
      if (statusCode == null) {
        return '不明なエラー';
      }
      if (statusCode >= 400 && statusCode < 500) {
        return 'クライエントエラー';
      } else if (statusCode >= 500 && statusCode < 600) {
        return 'サーバーエラー';
      } else {
        return '不明なエラー';
      }
    } else if (dioException.type == DioExceptionType.unknown) {
      return '不明なエラー';
    } else {
      return 'ネットワークに接続できませんでした。';
    }
  }
}
