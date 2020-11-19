import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'fit_check_demo.dart';

void main() => runApp(StepDemo());

class StepDemo extends StatefulWidget {
  @override
  _StepDemoState createState() => _StepDemoState();
}

class _StepDemoState extends State<StepDemo> {

  static var now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day);

  Future<List<HealthDataPoint>> _getHealthDataPoints() async {

    List<HealthDataType> types = [
      HealthDataType.HEART_RATE,
    ];

    DateTime startDate = yesterday;
    DateTime endDate = DateTime.now();

    List<HealthDataPoint> healthDataList = List<HealthDataPoint>();

//    Future.delayed(Duration(seconds: 2), () async {
//      bool isAuthorized = await Health.requestAuthorization();
//      if (isAuthorized) {
//        for (HealthDataType type in types) {
//          /// Calls to 'Health.getHealthDataFromType' must be wrapped in a try catch block.
//          try {
//            List<HealthDataPoint> healthData = await Health.getHealthDataFromType(startDate, endDate, type);
//            healthDataList.addAll(healthData);
//          } catch (exception) {
//            print(exception.toString());
//          }
//        }
//      }
//      /// Do something with the health data list
//      for (var healthData in healthDataList) {
//        print(healthData);
//      }
//      if(isAuthorized) {
//        print('FUUUUUUUUUCKING AUTHORIZED FUCKKKKKKK');
//      }
//    });

    bool isAuthorized = await Health.requestAuthorization();
    if (isAuthorized) {
      for (HealthDataType type in types) {
        /// Calls to 'Health.getHealthDataFromType' must be wrapped in a try catch block.
        try {
          List<HealthDataPoint> healthData = await Health.getHealthDataFromType(startDate, endDate, type);
          healthDataList.addAll(healthData);
        } catch (exception) {
          print(exception.toString());
        }
      }
    }

//    for (var healthData in healthDataList) {
//        print(healthData);
//    }

    return healthDataList;
  }

  @override
  void initState() {
    super.initState();
//    print(_getHealthDataPoints());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getHealthDataPoints(),
      initialData: "Loading text..",
      builder: (BuildContext context, AsyncSnapshot jay) {
        dynamic avgHeartBeat = 0;
        for(var i=0;i<jay.data.length;++i){
          avgHeartBeat += jay.data[i].value;
        }
        avgHeartBeat = avgHeartBeat / jay.data.length;
        avgHeartBeat = avgHeartBeat.toInt();
        return Scaffold(
          body: Container(
            decoration: new BoxDecoration(color: Colors.white),
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            colors: [Colors.blue[100], Colors.blue[400]],
//          ),
//        ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top:20),
                child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/heart-beats.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'HEART BEAT TODAY',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Bebas',
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      avgHeartBeat.toString(),
                      style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }


}