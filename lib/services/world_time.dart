import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String area;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.area ,required this.flag, required this.url});

  Future<void> getTime() async{

    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      DateTime now = DateTime.parse(datetime.substring(0,26));

      isDayTime = now.hour > 1 && now.hour < 12 ? true : false;
      time = DateFormat.Hm().format(now);

    }catch(e){
      print(e);
      time = 'Could not get time data';
    }

  }

}
