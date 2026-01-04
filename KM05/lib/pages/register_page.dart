import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Register Page')),
    );
  }
}
