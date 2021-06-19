import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {

      });
    });
    super.initState();
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    print(data['isDayTime']);

    print(data['time']);
    print(DateTime.now());

    var bgColor = data['isDayTime'] ? Colors.white : Color(0xFF142550);
    var txtColor = data['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 15,
                    primary: Colors.pink,
                    shadowColor: Colors.pink,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15)),
                child: Icon(
                  Icons.edit_location,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'area': result['area'],
                      'isDayTime': result['isDayTime']
                    };
                  });
                },
              ),

              SizedBox(height: 50,),

              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: CustomPaint(
                      painter: ClockPainter(data['time'].substring(0,2), data['time'].substring(3,5), bgColor, txtColor),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Center(
                child: Text(data['location'], style: TextStyle(
                  fontFamily: 'SpaceBold',
                  fontSize: 28,
                  color: Colors.pink,
                ),),
              ),
              Center(
                child: Text(data['time'], style: TextStyle(
                  fontFamily: 'SpaceBold',
                  fontSize: 60,
                  color: txtColor,
                ),),
              ),
              Center(
                child: Text(data['area'], style: TextStyle(
                  fontFamily: 'SpaceBold',
                  fontSize: 20,
                  color: Colors.grey,
                ),),
              ),




            ],
          ),
        ),
      ),
    );
  }
}



class ClockPainter extends CustomPainter{
  late String hour;
  late String minute;
  var bgColor;
  var hourColor;
  ClockPainter(String hour, String minute, var color, var hourColor){
    this.hour = hour;
    this.minute = minute;
    this.bgColor = color;
    this.hourColor = hourColor;
  }


  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
      ..color = bgColor;

    var outlineBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = Color(0xFFe7eefb);

    var centerfillBrush = Paint()
      ..color = Colors.pink;

    var secHandBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.pink;

    var minHandBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.grey;

    var hourHandBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = hourColor;

    canvas.drawCircle(center, radius - 15, fillBrush);
    canvas.drawCircle(center, radius - 15, outlineBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi/180);
    var secHandY = centerY + 80 * sin(dateTime.second * 6 * pi/180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    // var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi/180);
    // var minHandY = centerY + 80 * sin(dateTime.minute * 6 * pi/180);

    var minHandX = centerX + 80 * cos(int.parse(minute) * 6 * pi/180);
    var minHandY = centerY + 80 * sin(int.parse(minute) * 6 * pi/180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var hourHandX = centerX + 60 * cos((int.parse(hour) * 30 + int.parse(minute) * 0.5) * pi/180);
    var hourHandY = centerY + 60 * sin((int.parse(hour) * 30 + int.parse(minute) * 0.5) * pi/180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    canvas.drawCircle(center, 7, centerfillBrush);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
