import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestResult extends StatefulWidget {
  const TestResult({Key? key}) : super(key: key);

  @override
  TestResultState createState() => TestResultState();
}

class TestResultState extends State<TestResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:
              const Text('Test Result', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(' Check out your test results ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontFamily: "roboto",
                      ))),
              const SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 232, 232),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(' Score Average: 3.0 / 5.0 ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: "roboto",
                      ))),
              const SizedBox(height: 10),
              SfCartesianChart(
                primaryXAxis: NumericAxis(
                    title: AxisTitle(text: 'field'), isVisible: false),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'score', textStyle: TextStyle(fontSize: 12)),
                ),
                series: <ChartSeries<MyResult, int>>[
                  ColumnSeries<MyResult, int>(
                    dataSource: <MyResult>[
                      MyResult(1, 2),
                      MyResult(2, 1),
                      MyResult(3, 5),
                      MyResult(4, 3),
                      MyResult(5, 4),
                    ],
                    xValueMapper: (MyResult result, _) => result.field,
                    yValueMapper: (MyResult result, _) => result.score,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    // the color of the column is changed
                    pointColorMapper: (MyResult result, _) {
                      if (result.score == 1) {
                        return Colors.red;
                      } else if (result.score == 2) {
                        return Colors.orange;
                      } else if (result.score == 3) {
                        return Colors.yellow;
                      } else if (result.score == 4) {
                        return Colors.green;
                      } else if (result.score == 5) {
                        return Colors.blue;
                      } else {
                        return Colors.black;
                      }
                    },
                  )
                ],
                title: ChartTitle(
                  text: '2022.12.07',
                  textStyle: TextStyle(fontSize: 12, fontFamily: "roboto"),
                ),
                legend: Legend(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
              Container(
                margin: const EdgeInsets.only(left: 2, right: 2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    Text(" Communicate", style: TextStyle(fontSize: 10)),
                    Text("Together", style: TextStyle(fontSize: 10)),
                    Text("Positive Mind", style: TextStyle(fontSize: 10)),
                    Text("Help & Care  ", style: TextStyle(fontSize: 10)),
                    Text("Stress   ", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.amber,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                      ' You are okay now, so try to keep mind healthy! ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "roboto",
                      ))),
            ]))));
  }
}

class MyResult {
  MyResult(this.field, this.score);
  final int field;
  final int score;
}
