import 'package:flutter/material.dart';

class WeatherListCell extends StatelessWidget {
  const WeatherListCell({super.key});

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
