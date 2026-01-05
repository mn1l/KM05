import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});

  final String title;

  @override
  State<HistoryPage> createState() => _LoginPageState();
}

class _HistoryPageState extends State<HistoryPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('History Page')),
    );
  }
}
