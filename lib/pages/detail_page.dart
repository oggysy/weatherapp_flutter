import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const List<String> weatherData = [
    '天気情報を表示',
    '天気情報を表示',
    '天気情報を表示',
    '天気情報を表示',
    '天気情報を表示'
  ];
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('北海道'),
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
              child: ListView.separated(
                itemCount: weatherData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(weatherData[index]),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailPage(),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
