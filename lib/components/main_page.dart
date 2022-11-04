// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/weather.dart';
import 'package:intl/intl.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  final user = FirebaseAuth.instance.currentUser;
  var size, width;

  String currentDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());

  String location = 'Ho Chi Minh';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                user?.displayName ?? "No name",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Ho Chi Minh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(
                color: Color.fromARGB(255, 102, 102, 102),
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MyWeather(location: location),
          ],
        ),
      ),
    );
  }
}
