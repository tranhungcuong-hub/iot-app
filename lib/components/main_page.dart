// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.home,
        color: Colors.black,
        size: 100,
      ),
    );
  }
}
