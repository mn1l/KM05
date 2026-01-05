import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  }
