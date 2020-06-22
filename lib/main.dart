import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testProject/Screens/Login.dart';
import 'package:testProject/maps_widget.dart';
import 'locations.dart' as locations;
import 'placeholder_widget.dart';
import 'home_page.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget { //might need to be sateless?
  static const String _title = 'uhhh';

  @override
  _MyAppState createState() => _MyAppState();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      //home: HomePage() ,
    );
  }
}

//MAPS

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    WelcomeScreen(),
    Maps(),
    HomePage(),
    PlaceholderWidget(Colors.black26),
  ];




  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



  //MAPS BELOW

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
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
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('COVID Notifier'),
          backgroundColor: Colors.blue[700],
        ),
        body: Container(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Sign In'),

            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.map),
              title: new Text('Maps'),

            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.radio_button_checked),
              title: new Text('Location Services'),

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
            ),
          ],
        ),




      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}

