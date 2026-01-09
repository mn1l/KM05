import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Auto', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Huren', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
    );
  }
}

