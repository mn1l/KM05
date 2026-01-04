import 'package:carsmeelien/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KM05 App',
      theme: appTheme,
      home: const MainPage(),
    );
  }
}
