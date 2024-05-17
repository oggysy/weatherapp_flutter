import 'package:flutter/material.dart';
import 'package:weatherapp_flutter/presentation/pages/home_page.dart';
import 'package:weatherapp_flutter/service/location_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(
        locationService: LocationService(),
      ),
    );
  }
}
