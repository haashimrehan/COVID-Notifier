import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'main.dart';
import 'home_page.dart';


class Maps extends StatefulWidget {
  const Maps({ Key key }) : super(key: key);

  @override
  _Maps createState() => _Maps ();
}

class _Maps extends State<Maps> {

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) { //haashim change to our users in db
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(userLat, userLng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Circle> circles = Set.from([Circle(
      circleId: CircleId("my circle"),
      center: LatLng(userLat, userLng),
      radius: 40,
    )]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: 2220,
          height: 750,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(userLat, userLng),
              zoom: 15,
            ),
            markers: _markers.values.toSet(),
            circles: circles,
          ),

        ),
      ),
    );
  }
}



