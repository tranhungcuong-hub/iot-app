// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/detail/lightChart.dart';

//Create a shader linear gradient
final Shader linearGradient = const LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 227, 241, 255),
    Color.fromARGB(255, 225, 236, 252)
  ],
).createShader(const Rect.fromLTWH(255.0, 255.0, 255.0, 255.0));

class MyLightView extends StatefulWidget {
  const MyLightView({super.key});

  @override
  State<MyLightView> createState() => _MyLightViewState();
}

class _MyLightViewState extends State<MyLightView> {
  final Color secondaryColor = const Color(0xff90B2F8);
  var size, width;
  late List<dynamic> lightData;
  bool isLoadingEnded = false;

  late List<dynamic> day;

  Future _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://io.adafruit.com/api/v2/trungbui2405/feeds/dadn.cambien-anhsang/data'));
    List<dynamic> data = json.decode(response.body);
    day = getData(data);
    print(day);
    isLoadingEnded = true;
    setState(() {
      lightData = data;
    });
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
                  top: 30,
                  left: 20,
                  child: Text(
                    'Light',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLightChart(
                            data: day,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Detail',
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          lightData[0]['value'].toString(),
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),
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
