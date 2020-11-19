import 'package:demo_app/step.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'fit_check_demo.dart';
import 'fetish.dart';
import 'step.dart';
import 'sleep.dart';

void main() => runApp(Check());

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {

  void _getHealthDataPoints() async {

//    List<HealthDataType> types = [
//      HealthDataType.STEPS,
//      HealthDataType.HEART_RATE,
//    ];
//
//    DateTime startDate = DateTime.utc(2001, 01, 01);
//    DateTime endDate = DateTime.now();
//
//    List<HealthDataPoint> healthDataList = List<HealthDataPoint>();

    Future.delayed(Duration(seconds: 2), () async {
      bool isAuthorized = await Health.requestAuthorization();
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
        if(isAuthorized) {
          print('FUUUUUUUUUCKING AUTHORIZED');
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _getHealthDataPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('check'),
//        centerTitle: true,
//      ),
      body: Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Center(
          child: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fetish()),
                    );
                  },
                  child: Image(
                    image: AssetImage('assets/legs.png'),
                    width: 195,
                    height: 195,
                  )
                ),
                Text(
                  'Steps',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bebas',
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StepDemo()),
                    );
                  },
                  child: Image(
                    image: AssetImage('assets/h.png'),
                    width: 195,
                    height: 195,
                  )
                ),
                Text(
                  'Heart Rate',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bebas',
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sleep()),
                      );
                    },
                    child: Image(
                      image: AssetImage('assets/bed.png'),
                      width: 195,
                      height: 195,
                    )
                ),
                Text(
                  'Sleep',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bebas',
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}