import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

double userLat = 5.0;
double userLng = 5.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${userLat}, LNG: ${userLng}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );

  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLat = position.latitude;
        userLng = position.longitude;


      });
    }).catchError((e) {
      print(e);
    });
  }
}