import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:weatherapp_flutter/presentation/pages/weather_list_cell.dart';

class DetailPage extends StatelessWidget {
  final Map<String, List<String>> weather = const {
    '5月10日': ['天気情報1', '天気情報2'],
    '5月11日': ['天気情報3', '天気情報4', '天気情報5', '天気情報6', '天気情報7'],
  };
  final String prefecture;
  const DetailPage({required this.prefecture, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              prefecture,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Text('2024年5月13日'),
            const Text('降水確率'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity, // 幅
                height: 200.0, // 高さ
                color: Colors.black, // 背景色
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weather.length,
                itemBuilder: (context, index) {
                  String date = weather.keys.elementAt(index);
                  List<String> dailyEvents = weather[date]!;
                  return StickyHeader(
                    header: Container(
                      height: 30.0,
                      color: Color.fromARGB(249, 244, 244, 244),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        date,
                      ),
                    ),
                    content: Column(
                      children: dailyEvents
                          .map((event) => WeatherListCell())
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
