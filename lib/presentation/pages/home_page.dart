import 'package:flutter/material.dart';
import 'package:weatherapp_flutter/presentation/component/alert/setting_transition_alert_dialog.dart';
import 'package:weatherapp_flutter/presentation/component/notification_button.dart';
import 'package:weatherapp_flutter/presentation/pages/detail_page.dart';
import 'package:weatherapp_flutter/presentation/pages/prefecture_select_page.dart';
import 'package:weatherapp_flutter/service/location_service.dart';
import 'package:weatherapp_flutter/service/notification_service.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    this.locationService = LocationService.instance,
  }) : notificationService = NotificationService();

  final LocationService locationService;
  final NotificationService notificationService;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SettingTransitionAlertDialog(
          title: '位置情報が許可されていません',
          message: '設定から許可を行ってください。',
        );
      },
    );
  }

  @override
  void initState() {
    widget.notificationService.initializeNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          actions: [
            NotificationButton(),
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
              onPressed: () async {
                final position =
                    await widget.locationService.getCurrentLocation();
                if (!context.mounted) return;

                if (position != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        lat: position.latitude,
                        lon: position.longitude,
                      ),
                    ),
                  );
                } else {
                  _showPermissionDeniedDialog();
                }
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
