import 'package:flutter/material.dart';
import 'package:mausam/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String city = "Indore";
  String temp="";
  String hum="";
  String airSpeed="";
  String description="";
  String main="";
  String icon="";

  void startApp(String city) async
  {
    worker instance  = worker(location:city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    airSpeed = instance.airSpeed;
    description = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home',arguments: {

        "temp_value" : temp,
        "hum_value" : hum,
        "airSpeed_value" : airSpeed,
        "des_value" : description,
        "main_value" : main,
        "icon_value" : icon,
        "city_value" : city,




      } );
    });

  }

  @override
  void initState() {




    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if(search?.isNotEmpty ?? false)
    {
      city = search?['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("images/w.png",height: 240,width: 240,),//TODO add image
              Text("Mausam App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
                ),

              // SizedBox(height: 10,),
              Text("Made By Tushar",
                style: TextStyle(
                    fontSize: 18,
                ),),
              SizedBox(height: 40,),
              SpinKitFadingFour(
                color: Colors.black26,
                size: 50.0,
              ),

            ],
          ),

        ),
      ),
      backgroundColor: Colors.blueAccent,

    );


  }
}