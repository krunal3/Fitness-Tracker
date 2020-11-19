import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';

class FitCheckDemo extends StatefulWidget {
  @override
  _FitCheckDemoState createState() => _FitCheckDemoState();
}

class _FitCheckDemoState extends State<FitCheckDemo> {

  void read() async {
    final results = await FitKit.read(
      DataType.STEP_COUNT,
      dateFrom: DateTime.now().subtract(Duration(days: 5)),
      dateTo: DateTime.now(),
    );
    print(results);
  }

  void sleep() async {
    final results = await FitKit.read(
      DataType.SLEEP,
      dateFrom: DateTime.now().subtract(Duration(days: 5)),
      dateTo: DateTime.now(),
    );
    print(results);
  }

  void readLast() async {
    final result = await FitKit.readLast(DataType.HEIGHT);
  }

  void readAll() async {
    if (await FitKit.requestPermissions(DataType.values)) {
      for (DataType type in DataType.values) {
        final results = await FitKit.read(
          type,
          dateFrom: DateTime.now().subtract(Duration(days: 5)),
          dateTo: DateTime.now(),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
    print('SLEEEEEEEEEEEEEEEEP');
    sleep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fit check demo'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
      ),
    );;
  }
}
