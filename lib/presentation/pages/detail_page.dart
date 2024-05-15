import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
                          .map((event) => const _WeatherListCell())
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

class _WeatherListCell extends StatelessWidget {
  const _WeatherListCell();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text('18:00'),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset('assets/images/splash_logo.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '最高気温:',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '最低気温:',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '湿度:',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
