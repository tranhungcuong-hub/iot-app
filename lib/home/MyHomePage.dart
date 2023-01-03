// ignore: file_names
import 'package:flutter/material.dart';
import 'package:my_app/components/control_button.dart';

import '../components/main_page.dart';
import '../components/Info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    MyMainPage(),
    ControlSignalPage(),
    InfomationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (int newIndex) async {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Control',
            icon: Icon(Icons.signal_cellular_0_bar),
          ),
          BottomNavigationBarItem(
            label: 'Information',
            icon: Icon(Icons.air),
          ),
        ],
      ),
    );
  }
}
