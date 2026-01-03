import 'package:carsmeelien/components/navbar.dart';
import 'package:carsmeelien/services/auth/login.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _exampleFunc() {
    setState(() async{
      String idToken = await login('admin', 'admin');
      print(idToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: const [
          Expanded(child: Center(child: Text('Home Page'))),
          NavBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _exampleFunc,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
