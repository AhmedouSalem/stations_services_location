// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   List<Marker> geoJsonMarkers = [];
//   final MapController _mapController = MapController();
//   LatLng? userLocation;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLocation();
//     _loadGeoJsonData();
//   }

//   void _startListeningToLocation() {
//     Geolocator.getPositionStream().listen((Position position) {
//       setState(() {
//         userLocation = LatLng(position.latitude, position.longitude);
//       });
//     });
//   }
//   // Future<void> _getUserLocation() async {
//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);
//   //   setState(() {
//   //     userLocation = LatLng(position.latitude, position.longitude);
//   //   });
//   // }

//   Future<void> _loadGeoJsonData() async {
//     final response = await http.get(Uri.parse(
//         'http://172.20.10.5:8080/geoserver/nkc_map/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=nkc_map%3Afuel_1,nkc_map%3Afuel_2&maxFeatures=50&outputFormat=application%2Fjson'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final features = data['features'];

//       List<Marker> markers = [];
//       for (var feature in features) {
//         final geometry = feature['geometry'];
//         if (geometry['type'] == 'Point') {
//           final coordinates = geometry['coordinates'];
//           final point = LatLng(coordinates[1], coordinates[0]);
//           markers.add(Marker(
//             width: 80.0,
//             height: 80.0,
//             point: point,
//             child: const Icon(
//               Icons.local_gas_station,
//               color: Colors.red,
//               size: 20.0,
//             ),
//           ));
//         }
//       }

//       setState(() {
//         geoJsonMarkers = markers;
//       });
//     } else {
//       throw Exception('Failed to load GeoJSON data');
//     }
//   }

//   void _zoomIn() {
//     _mapController.move(_mapController.center, _mapController.zoom + 1);
//   }

//   void _zoomOut() {
//     _mapController.move(_mapController.center, _mapController.zoom - 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Stations Services à Nouakchott"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               onTap: (tapPosition, point) {
//                 print(point.longitude);
//               },
//               onMapEvent: (p0) {
//                 p0.camera;
//               },
//               initialCenter: const LatLng(18.079021,
//                   -15.965238), // Coordonées approximatives de Nouakchott
//               initialZoom: 13.0,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate:
//                     'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: const ['a', 'b', 'c'],
//               ),
//               MarkerLayer(
//                 markers: geoJsonMarkers,
//               ),
//               if (userLocation !=
//                   null) // Afficher le marqueur de la position de l'utilisateur
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       width: 80.0,
//                       height: 80.0,
//                       point: userLocation!,
//                       child: const Icon(
//                         Icons.person_pin_circle,
//                         color: Colors.blue,
//                         size: 40.0,
//                       ),
//                     )
//                   ],
//                 ),
//             ],
//           ),
//           Positioned(
//             top: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   onPressed: _zoomIn,
//                   child: const Icon(Icons.zoom_in),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton(
//                   onPressed: _zoomOut,
//                   child: const Icon(Icons.zoom_out),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
