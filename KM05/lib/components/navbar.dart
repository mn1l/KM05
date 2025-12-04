import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _tapFunc() {
    return;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: Row(
        children: [
          GestureDetector(
            onTap: _tapFunc,
            child: Icon(Icons.favorite)
          ),
        ],
      ),
    );
  }
}
