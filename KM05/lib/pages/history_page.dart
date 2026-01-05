import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key, required this.title});

  final String title;

  @override
  State<MyHistoryPage> createState() => _MyLoginPageState();
}

class _MyHistoryPageState extends State<MyHistoryPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('History Page')),
    );
  }
}
