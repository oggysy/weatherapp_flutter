import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:weatherapp_flutter/extension/date_time_extension.dart';
import 'package:weatherapp_flutter/extension/weather_response_extension.dart';
import 'package:weatherapp_flutter/presentation/component/pop_chart.dart';
import 'package:weatherapp_flutter/service/weathre_api_service.dart';

class DetailPage extends StatefulWidget {
  final String prefecture;
  final WeathreAPIService service;
  const DetailPage({
    required this.prefecture,
    super.key,
  }) : service = WeathreAPIService.instance;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String currentDate = DateTime.now().dateAsStringYMD;
  @override
  void initState() {
    _fetchWeathre();
    super.initState();
  }

  void _fetchWeathre() async {
    final data =
        await widget.service.fetchWeatherFromCity(city: widget.prefecture);
    setState(() {
      timePopData = data.timeAndPopList;
    });
  }

  List<Map<String, int>> timePopData = [];
  final Map<String, List<String>> weather = const {
    '5月10日': [
      '天気情報1',
      '天気情報2',
    ],
    '5月11日': [
      '天気情報3',
      '天気情報4',
      '天気情報5',
      '天気情報6',
      '天気情報7',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.prefecture,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(currentDate),
            const Text('降水確率'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity, // 幅
                height: 200.0, // 高さ
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopChart(
                    key: ValueKey(timePopData.hashCode),
                    timePopData: timePopData,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weather.length,
                itemBuilder: (context, index) {
                  String date = weather.keys.elementAt(index);
                  List<String> dailyEvents = weather[date] ?? [];
                  return StickyHeader(
                    header: Container(
                      height: 30.0,
                      color: const Color.fromARGB(249, 244, 244, 244),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        date,
                      ),
                    ),
                    content: Column(
                      children: dailyEvents
                          .map((event) => const _WeatherListCell(
                              maxTemperature: '25.0',
                              minTemperature: '10.0',
                              humidityLevel: '50',
                              imageName: 'rain',
                              time: '18:00'))
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
  final String time;
  final String imageName;
  final String maxTemperature;
  final String minTemperature;
  final String humidityLevel;
  const _WeatherListCell(
      {required this.maxTemperature,
      required this.minTemperature,
      required this.humidityLevel,
      required this.imageName,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(time),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/images/splash_logo.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '最高気温:$maxTemperature ℃',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '最低気温:$minTemperature ℃',
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '湿度:$humidityLevel %',
                style: const TextStyle(
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
