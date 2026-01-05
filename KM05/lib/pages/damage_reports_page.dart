import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyDamageReportsPage extends StatefulWidget {
  const MyDamageReportsPage({super.key, required this.title});

  final String title;

  @override
  State<MyDamageReportsPage> createState() => _MyLoginPageState();
}

class _MyDamageReportsPageState extends State<MyDamageReportsPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Damage Reports Page')),
    );
  }
}
