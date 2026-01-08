import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: 'Registreren'),
      body: const Center(child: Text('Register Page')),
    );
  }
}
