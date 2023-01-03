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

final Shader linearGradient = const LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 227, 241, 255),
    Color.fromARGB(255, 225, 236, 252)
  ],
).createShader(const Rect.fromLTWH(255.0, 255.0, 255.0, 255.0));

class Ledbutton extends StatefulWidget {
  const Ledbutton({super.key});

  @override
  State<Ledbutton> createState() => _LedbuttonState();
}

class _LedbuttonState extends State<Ledbutton> {
  final Color secondaryColor = const Color(0xff90B2F8);
  final user = FirebaseAuth.instance.currentUser;
  late bool status8;
  bool isLoadingEnded = false;
  var size, width;

  String aioKey = "aio_LlkF07L3BOX9jv5dlbsEHFRwKwv8";
  String currentDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());
  String location = 'Ho Chi Minh';

  late List<dynamic> day;
  late List<dynamic> humidityData;

  Future _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://io.adafruit.com/api/v2/trungbui2405/feeds/dadn.led/data'));
    List<dynamic> data = json.decode(response.body);
    day = getData(data);
    isLoadingEnded = true;
    setState(() {
      if (day[0][1] == '1') {
        status8 = true;
      } else {
        status8 = false;
      }
    });
  }

  Future<bool> createData(String value) async {
    http.Response response = await http.post(
      Uri.parse(
          'https://io.adafruit.com/api/v2/trungbui2405/feeds/dadn.led/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;

    return Container(
      width: width,
      height: 170,
      margin: const EdgeInsets.only(bottom: 50, top: 0, left: 10, right: 10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withOpacity(.5),
            offset: const Offset(0, 25),
            blurRadius: 10,
            spreadRadius: -12,
          )
        ],
      ),
      child: isLoadingEnded == true
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    'Led',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Press button to turn led on or off',
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: status8,
                        borderRadius: 30.0,
                        padding: 2.0,
                        activeToggleColor: Color.fromARGB(255, 253, 198, 2),
                        inactiveToggleColor: Color.fromARGB(255, 193, 232, 255),
                        activeSwitchBorder: Border.all(
                          color: Colors.white,
                          width: 6.0,
                        ),
                        inactiveSwitchBorder: Border.all(
                          color: Colors.white,
                          width: 6.0,
                        ),
                        activeColor: Color.fromARGB(255, 255, 227, 71),
                        inactiveColor: Color.fromARGB(255, 123, 180, 255),
                        activeIcon: const Icon(FontAwesomeIcons.lightbulb),
                        inactiveIcon:
                            const Icon(FontAwesomeIcons.solidLightbulb),
                        onToggle: (val) {
                          setState(() {
                            if (val) {
                              createData("1");
                            } else {
                              createData("0");
                            }
                            status8 = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  List<dynamic> getData(List<dynamic> data) {
    List<dynamic> figures = [];

    var n = data.length > 7 ? 7 : data.length;

    for (var i = 0; i < n; i++) {
      figures.add([
        data[i]['created_at'].toString().substring(0, 10),
        data[i]['value'].toString(),
      ]);
    }

    return figures;
  }
}
