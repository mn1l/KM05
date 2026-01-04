import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Hallo', style: AppAppBar.titleTextStyle1),
              TextSpan(text: ' Kars!', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: const Center(child: Text('Profile Page')),
    );
  }
}
