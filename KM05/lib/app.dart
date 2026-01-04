import 'package:carsmeelien/pages/main_page.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KM05 App',
      theme: themeData,
      home: const MainPage(),
    );
  }
}
