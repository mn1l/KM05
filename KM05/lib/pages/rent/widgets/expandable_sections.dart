import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';

class ExpandableSections extends StatelessWidget {
  final Car car;

  const ExpandableSections({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (car.inspections != null && car.inspections!.isNotEmpty)
          ExpansionTile(
            title: const Text('Inspecties', style: TextStyle(fontWeight: FontWeight.bold)),
            children: car.inspections!
                .map((i) => ListTile(title: Text(i.description)))
                .toList(),
          ),
        if (car.repairs != null && car.repairs!.isNotEmpty)
          ExpansionTile(
            title: const Text('Reparaties', style: TextStyle(fontWeight: FontWeight.bold)),
            children: car.repairs!
                .map((r) => ListTile(title: Text(r.description)))
                .toList(),
          ),
      ],
    );
  }
}