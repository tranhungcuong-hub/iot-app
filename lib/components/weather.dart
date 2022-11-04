// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

//Create a shader linear gradient
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class MyWeather extends StatefulWidget {
  final String location;

  const MyWeather({Key? key, required this.location}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState(location);
}

class _MyWeatherState extends State<MyWeather> {
  bool isLoadingEnded = false;
  final Color secondaryColor = const Color(0xff90B2F8);
  var size, width, imageUrl;
  late Map<String, dynamic> weatherData;

  _MyWeatherState(location);

  Future _fetchData(location) async {
    final response = await http.get(Uri.parse(weatherApiUrl(location)));
    Map<String, dynamic> data = json.decode(response.body);
    print(data['days'][0]['preciptype'][0]);
    // String datetime = data[8][0];
    isLoadingEnded = true;
    setState(() {
      weatherData = data;
    });
  }

  @override
  void initState() {
    _fetchData(widget.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;

    return Container(
      width: width,
      height: 200,
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
                Positioned(
                  top: -40,
                  left: 20,
                  child: Image.asset(
                    // ignore: prefer_interpolation_to_compose_strings
                    'assets/images/' +
                        weatherData['days'][0]['preciptype'][0].toString() +
                        '.png',
                    width: 150,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Text(
                    weatherData['days'][0]['conditions'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                          weatherData['days'][0]['temp'].round().toString(),
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ),
                      Text(
                        'o',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      )
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
}

String weatherApiUrl(String str) {
  String newStr = str.replaceAll(RegExp(r' '), '%20');
  String apiUrl1 =
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';
  String apiUrl2 =
      '?unitGroup=metric&key=GRGSJG5LZXGBNXC4ASQSV9DQ4&contentType=json';
  newStr = apiUrl1 + newStr + apiUrl2;
  return newStr;
}
