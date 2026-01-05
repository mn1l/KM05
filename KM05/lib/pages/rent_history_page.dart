import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class RentHistoryPage extends StatefulWidget {
  const RentHistoryPage({super.key});

  @override
  State<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends State<RentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: 'Huurhistorie'),
      body: const Center(child: Text('History Page')),
    );
  }
}
