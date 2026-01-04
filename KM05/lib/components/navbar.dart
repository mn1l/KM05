import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Huurproces', style: optionStyle),
    Text('Index 2: Profiel', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
Widget build(BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0xFF00509D), 
    selectedItemColor: const Color(0xFFFFCB05), 
    unselectedItemColor: Colors.white, 
    currentIndex: _selectedIndex,
    onTap: _onItemTapped,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.car_rental),
        label: 'Huurproces',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profiel',
      ),
    ],
  );
}
}
