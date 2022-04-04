// ignore_for_file: avoid_print, deprecated_member_use, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:smaretapp/module.dart';
import 'dart:convert' as convert;
import 'Env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationApp(null),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationApp extends StatefulWidget {
  const LocationApp(param0, {Key? key}) : super(key: key);

  get driver => null;

  @override
  State<LocationApp> createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  Position? p;
  String? train;
  Driver? driver;

  // ignore: non_constant_identifier_names
  Future CheckServesesLocation() async {
    bool serves;
    LocationPermission per;
    serves = await Geolocator.isLocationServiceEnabled();
    if (serves == false) {
      //Alert(context: context, title: "Error", desc: "Servese not enable.")
      //.show();

      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
        if (per == LocationPermission.always) {
          return true;
          //p = await Geolocator.getCurrentPosition().then((value) => value);
          // print("lat ${p.latitude}");
        } //print("long ${p.longitude}");
      }
    }
  }

  Future<Driver> createDriver(String train, String lalit, String longit) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/create.php"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'train': widget.driver.train,
        'lalitude': widget.driver.latit.toString(),
        'longitude': widget.driver.longit.toString(),
      }),
    );
    if (response.statusCode == 201) {
      return Driver.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('field create driver.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location services"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Container(
            width: 500,
          ),
          const Icon(
            Icons.location_on,
            size: 46.0,
            color: Colors.red,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            "Get user Location",
            style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              Spacer(),
              Text(
                "1",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "1",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer(),
              Text(
                "2",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "2",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer(),
              Text(
                "3",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "3",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer()
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              Spacer(),
              Text(
                "4",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "4",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer(),
              Text(
                "5",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "5",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer(),
              Text(
                "6",
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              Radio(
                  value: "6",
                  groupValue: train,
                  onChanged: (val) {
                    setState(() {
                      train = val.toString();
                    });
                  }),
              Spacer()
            ],
          ),
          Spacer(),
          FlatButton(
            minWidth: 250.0,
            height: 50.0,
            color: Color.fromARGB(255, 6, 255, 19),
            onPressed: () async {
              CheckServesesLocation();
              p = await Geolocator.getCurrentPosition().then((value) => value);
              String? toul = p?.latitude.toString();
              String? aarth = p?.longitude.toString();
              if (train == null) {
                Alert(
                        context: context,
                        title: "Error",
                        desc: "Select the train.")
                    .show();
              } else {
                createDriver(train!, toul!, aarth!);
              }
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
