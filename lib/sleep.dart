import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';

class Sleep extends StatefulWidget {
  @override
  _SleepState createState() => _SleepState();
}

class _SleepState extends State<Sleep> {

  static var now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day);

  Future<List<FitData>> read() async {
    print(now);
    print(yesterday);
    print('DATTTTTTTTTTTTTTTEEEEEEEEEEE');
    final results = await FitKit.read(
      DataType.STEP_COUNT,
      dateFrom: DateTime.utc(
          yesterday.year,
          yesterday.month,
          yesterday.day,
          yesterday.hour,
          yesterday.minute,
          yesterday.second
      ),
      dateTo: DateTime.now(),
    );
    return results;
  }

  Future<List<FitData>> sleep() async {
    final results = await FitKit.read(
      DataType.SLEEP,
      dateFrom: DateTime.utc(
          yesterday.year,
          yesterday.month,
          yesterday.day,
          yesterday.hour,
          yesterday.minute,
          yesterday.second
      ),
      dateTo: DateTime.now(),
    );
    return results;
  }

  void readLast() async {
    final result = await FitKit.readLast(DataType.HEIGHT);
  }

  void readAll() async {
    if (await FitKit.requestPermissions(DataType.values)) {
      for (DataType type in DataType.values) {
        final results = await FitKit.read(
          type,
          dateFrom: DateTime.utc(
              yesterday.year,
              yesterday.month,
              yesterday.day,
              yesterday.hour,
              yesterday.minute,
              yesterday.second
          ),
          dateTo: DateTime.now(),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    read();
//    print('SLEEEEEEEEEEEEEEEEP');
//    sleep();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sleep(),
      initialData: "Loading text..",
      builder: (BuildContext context, AsyncSnapshot jay) {
        var stepCountSum = 0;
        DateTime dateStart;
        DateTime dateEnd;
        for(var i=0;i<jay.data.length;++i){
          print("MADARA");
          dateStart = jay.data[i].dateFrom;
          dateEnd = jay.data[i].dateTo;
          Duration timeDiff = dateEnd.difference(dateStart);
          stepCountSum += timeDiff.inHours.toInt();
        }
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
                      image: AssetImage('assets/sleeping.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'SLEEP COUNT TODAY',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Bebas',
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      stepCountSum.toString(),
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
      },
    );
  }
}
