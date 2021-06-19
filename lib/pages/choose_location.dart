import 'package:flutter/material.dart';
import 'package:flutter_world_clock/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: "New York", area: 'America', flag: "assets/US.png", url: 'America/New_York'),
    WorldTime(location: "London", area: 'Europe', flag: "assets/UK.png", url: 'Europe/London'),
    WorldTime(location: "Athens", area: 'Europe', flag: "assets/Athens.png", url: 'Europe/Athens'),
    WorldTime(location: "Cairo", area: 'Africa', flag: "assets/Cairo.png", url: 'Africa/Cairo'),
    WorldTime(location: "Nairobi", area: 'Africa', flag: "assets/Nairobi.png", url: 'Africa/Nairobi'),
    WorldTime(location: "Chicago", area: 'America', flag: "assets/Chicago.png", url: 'America/Chicago'),
    WorldTime(location: "Seoul", area: 'Asia', flag: "assets/Seoul.png", url: 'Asia/Seoul'),
    WorldTime(location: "Jakarta", area: 'Asia', flag: "assets/Jakarta.png", url: 'Asia/Jakarta'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'area': instance.area,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Choose Location',
          style: TextStyle(
            fontFamily: 'SpaceBold',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index){
            return     Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 40,
                      maxHeight: 40,
                    ),
                    child: Image.asset(locations[index].flag, fit: BoxFit.cover),
                  ),
                  title: Text(locations[index].location, style: TextStyle(
                    fontFamily: 'SpaceBold',
                    fontSize: 18,
                  ),),
                  subtitle: Text(locations[index].area, style: TextStyle(
                    fontFamily: 'SpaceRegular',
                    color: Colors.grey
                  ),),
                ),
              ),
            );
          }
      )
    );
  }
}
