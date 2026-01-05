import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyDamageReportsPage extends StatefulWidget {
  const DamageReportsPage({super.key, required this.title});

  final String title;

  @override
  State<DamageReportsPage> createState() => _DamageReportsPageState();
}

class _DamageReportsPageState extends State<DamageReportsPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Damage Reports Page')),
    );
  }
}
