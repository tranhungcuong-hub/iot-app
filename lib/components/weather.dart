// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

//Create a shader linear gradient
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class _MyWeatherState extends State<MyWeather> {
  final Color secondaryColor = const Color(0xff90B2F8);
  var size, width, imageUrl;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;
    imageUrl = 'heavyrain';

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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -40,
            left: 20,
            child: Image.asset(
              'assets/images/' + imageUrl + '.png',
              width: 150,
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              'Rainning',
              style: TextStyle(
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
                    '17',
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
      ),
    );
  }
}
