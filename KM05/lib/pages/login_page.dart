import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: "Login Pagina"),
      body: const Center(child: Text('Login Page')),
    );
  }
}
