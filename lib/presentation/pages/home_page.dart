import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp_flutter/presentation/pages/detail_page.dart';
import 'package:weatherapp_flutter/presentation/pages/prefecture_select_page.dart';
import 'package:weatherapp_flutter/service/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.locationService = LocationService.instance});

  final LocationService locationService;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('位置情報が許可されていません'),
          content: const Text('設定から許可を行ってください。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
              child: const Text('設定に移動'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrefectureSelectPage()));
              },
              icon: const Icon(Icons.format_list_bulleted),
              label: const Text('都道府県を選択'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                textStyle: const TextStyle(fontSize: 16),
                fixedSize: const Size(190, double.infinity),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                widget.locationService.getCurrentLocation().then(
                  (position) {
                    if (position == null) {
                      _showPermissionDeniedDialog();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            lat: position.latitude,
                            lon: position.longitude,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
              icon: const Icon(Icons.near_me),
              label: const Text('現在地を取得'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                textStyle: const TextStyle(fontSize: 16),
                fixedSize: const Size(190, double.infinity),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
