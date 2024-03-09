import 'package:http/http.dart';
import 'dart:convert';

class worker
{
  String location;

  worker({this.location=""})
  {
    location = this.location;
  }


  String temp="";
  String humidity="";
  String airSpeed="";
  String description="";
  String main="";
  String icon="";


  Future<void> getData() async
  {
    try{
      Response response  =await get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$location&appid=0384d133ace7e948f5ce6a6e692a0285"));
      Map data = jsonDecode(response.body);


      //Getting Temp,Humidity
      Map temp_data = data['main'];
      int getHumidity = temp_data['humidity'];
      double getTemp = temp_data['temp'] - 273.15;

//Getting air_speed
      Map wind = data['wind'];
      double getAir_speed = wind["speed"]*3.6;


      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_Description = weather_main_data['main'];
      String getDescription = weather_main_data["description"];
      icon = (weather_main_data['icon']).toString();
      print(icon);




      //Assigning Values
      temp = getTemp.toString(); //C
      humidity = getHumidity.toString(); // %
      airSpeed = getAir_speed.toString(); //km/hr
      description = getDescription;
      main = getMain_Description;

    }catch(e)
    {
      print(e);
      temp = "NA";
      humidity = "NA";
      airSpeed = "NA";
      description = "Error , invalid input";
      main = "NA";
      icon = "09d";
    }



  }


}