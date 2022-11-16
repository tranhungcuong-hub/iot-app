// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyTempChart extends StatefulWidget {
  List<dynamic> data = [];
  MyTempChart({super.key, required this.data});

  @override
  State<MyTempChart> createState() => _MyTempChartState();
}

class _MyTempChartState extends State<MyTempChart> {
  final user = FirebaseAuth.instance.currentUser;
  var size, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;

    int step;
    List<ChartData> chartData = [];
    for (var i = 0; i < widget.data.length; i += step) {
      step = 1;
      if (i + 1 < widget.data.length) {
        for (var j = i + 1; j < widget.data.length; j++) {
          if (widget.data[i][0].toString().substring(8, 10) ==
              widget.data[j][0].toString().substring(8, 10)) {
            step++;
          } else {
            break;
          }
        }
        double x = double.parse(widget.data[i][1].toString());
        chartData.add(ChartData(widget.data[i][0], x));
        print(widget.data[i][0]);
      }
    }
    chartData = List.from(chartData.reversed);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
          children: [
            Container(
              width: width,
              height: 500,
              margin: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              // padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 25),
                    blurRadius: 10,
                    spreadRadius: -12,
                  )
                ],
              ),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Renders line chart
                  LineSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Temperature during a week",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
