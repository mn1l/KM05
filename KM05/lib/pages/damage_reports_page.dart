import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class DamageReportsPage extends StatefulWidget {
  const DamageReportsPage({super.key});

  @override
  State<DamageReportsPage> createState() => _DamageReportsPageState();
}

class _DamageReportsPageState extends State<DamageReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: 'Schademeldingen'),
      body: const Center(child: Text('Damage Reports Page')),
    );
  }
}
