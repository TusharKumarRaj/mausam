import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("Set State called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // print("Widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Mumbai",
      "Allahabad",
      "London",
      "Chennai",
      "Australia",
      "Delhi"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map? info = (ModalRoute.of(context)?.settings.arguments as Map?);

    String temp = ((info?['temp_value']).toString());
    String air = ((info?['airSpeed_value']).toString());

    if(temp=="NA")
    {
      print("NA");
    }
    else{
      temp = ((info?['temp_value']).toString()).substring(0,4);
      air = ((info?['airSpeed_value']).toString()).substring(0,4);

    }
    String icon = info?['icon_value'];
    String getcity = info?['city_value'];
    String hum = info?['hum_value'];
    String des = info?['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue[800]!,
                  Colors.blue[300]!,
                ])),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // stops: [
                    //     0.1,//0% se 10% tak ye rahega
                    //     0.8,//80% se 100% tak ye rahega
                    // ],

                    colors: [
                      Colors.blue[800]!,
                      Colors.blue[300]!,
                    ])),
            child: Column(
              children: [
                Container(
                  //Search Container
                  // color: Colors.grey,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == "")
                          {
                            print("Blank search");
                          }
                          else{
                            Navigator.pushReplacementNamed(context, "/loading",arguments: {
                              "searchText": searchController.text,
                            });
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search, color: Colors.blueAccent,),
                          margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search $city"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(26),
                          child: Row(
                            children: [
                              Image.network(
                                  "https://openweathermap.org/img/wn/$icon@2x.png"),
                              Column(
                                children: [
                                  Text("$des",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("In $getcity",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "$temp",
                                      style: TextStyle(
                                        fontSize: 85,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child: Text("°C",
                                        style: TextStyle(
                                          fontSize: 30,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Temperature"),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(26),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.cloudy_windy),
                                ],
                              ),
                              Container(
                                child: Text("$air",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    )),
                                margin: EdgeInsets.all(6),
                              ),
                              Text("Km/hr")
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(26),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(7),
                                child: Row(
                                  children: [
                                    Text("$hum",
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: Text("%",
                                          style: TextStyle(
                                            fontSize: 30,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Text("Humidity"))
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 28,),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Data Provided by Openweathermap.org"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
