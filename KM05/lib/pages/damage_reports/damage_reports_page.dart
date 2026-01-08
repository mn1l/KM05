import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/pages/damage_reports/widgets/damage_report_card.dart';

class DamageReportsPage extends StatefulWidget {
  const DamageReportsPage({super.key});

  @override
  State<DamageReportsPage> createState() => _DamageReportsPageState();
}

class _DamageReportsPageState extends State<DamageReportsPage> {
  // Nep data
  final List<Map<String, dynamic>> damageReports = [
    {
      'carModel': 'Tesla Model 3',
      'kilometerstand': '45.000',
      'beschrijving': 'Kras op de voorbumper aan de rechterkant. De kras is ongeveer 10 cm lang.',
      'fotoUrls': [
        'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&h=300&fit=crop',
      ],
    },
    {
      'carModel': 'BMW i3',
      'kilometerstand': '32.500',
      'beschrijving': 'Deuk in de achterdeur aan de linkerkant. Geen lakschade.',
      'fotoUrls': [
        'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=400&h=300&fit=crop',
      ],
    },
    {
      'carModel': 'Audi A1',
      'kilometerstand': '28.000',
      'beschrijving': 'Kleine steenslag op de voorruit. Geen verdere schade.',
      'fotoUrls': [
        'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=400&h=300&fit=crop',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Schade', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Meldingen', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: damageReports.isEmpty
            ? const Center(
                child: Text(
                  'Geen schademeldingen gevonden',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: damageReports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final report = damageReports[index];
                  return DamageReportCard(
                    carModel: report['carModel']!,
                    kilometerstand: report['kilometerstand']!,
                    beschrijving: report['beschrijving']!,
                    fotoUrls: (report['fotoUrls'] as List<dynamic>).cast<String>(),
                  );
                },
              ),
      ),
    );
  }
}
