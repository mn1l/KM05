import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyRentPage extends StatefulWidget {
  const MyRentPage({super.key, required this.title});

  final String title;

  @override
  State<MyRentPage> createState() => _MyRentPageState();
}

class _MyRentPageState extends State<MyRentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Rent Page')),
    );
  }
}

