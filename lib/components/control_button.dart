// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_app/authentication/authenticate.dart';
import 'package:my_app/components/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/figure/led_button.dart';
import 'package:my_app/figure/pump_button.dart';

final Shader linearGradient = const LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 227, 241, 255),
    Color.fromARGB(255, 225, 236, 252)
  ],
).createShader(const Rect.fromLTWH(255.0, 255.0, 255.0, 255.0));

class ControlSignalPage extends StatefulWidget {
  const ControlSignalPage({super.key});

  @override
  State<ControlSignalPage> createState() => _ControlSignalPageState();
}

class _ControlSignalPageState extends State<ControlSignalPage> {
  final Color secondaryColor = const Color(0xff90B2F8);
  final user = FirebaseAuth.instance.currentUser;
  late bool status8;
  bool isLoadingEnded = false;
  var size, width;

  String aioKey = "aio_LlkF07L3BOX9jv5dlbsEHFRwKwv8";
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
            const Ledbutton(),
            const Pumpbutton(),
          ],
        ),
      ),
    );
  }
}
