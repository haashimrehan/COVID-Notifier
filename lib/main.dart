import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testProject/Screens/Login.dart';
import 'locations.dart' as locations;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}

// class MyApp extends StatefulWidget { //might need to be sateless?
//   static const String _title = 'Flutter Code Sample';

//   @override
//   _MyAppState createState() => _MyAppState();
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//     );
//   }

// }


// //MAPS

// class _MyAppState extends State<MyApp> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }


//   //MAPS BELOW

//   final Map<String, Marker> _markers = {};
//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     final googleOffices = await locations.getGoogleOffices();
//     setState(() {
//       _markers.clear();
//       for (final office in googleOffices.offices) {
//         final marker = Marker(
//           markerId: MarkerId(office.name),
//           position: LatLng(office.lat, office.lng),
//           infoWindow: InfoWindow(
//             title: office.name,
//             snippet: office.address,
//           ),
//         );
//         _markers[office.name] = marker;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('does this work?? '),
//           backgroundColor: Colors.red[700],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 0, //CHANGE LATER
//           items: [
//             BottomNavigationBarItem(
//               icon: new Icon(Icons.home),
//               title: new Text('Home'),

//             ),
//             BottomNavigationBarItem(
//               icon: new Icon(Icons.mail),
//               title: new Text('Messages'),

//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               title: Text('Profile')
//             ),
//           ],
//         ),
//         body: Container(
//           width: 2220,
//           height: 630,
//           child: GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: const LatLng(0, 0),
//               zoom: 2,
//             ),
//             markers: _markers.values.toSet(),
//           ),

//         )

//       ),
//     );
//   }
// }