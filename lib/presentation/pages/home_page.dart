import 'package:flutter/material.dart';
import 'package:weatherapp_flutter/presentation/pages/prefecture_select_page.dart';
import 'package:weatherapp_flutter/service/location_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) : locationService = LocationService();

  final LocationService locationService;

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
                        builder: (context) => PrefectureSelectPage()));
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
              onPressed: () async {
                final position = await locationService.getCurrentLocation();
                print(position?.latitude);
                print(position?.longitude);
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
