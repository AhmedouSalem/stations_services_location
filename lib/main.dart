// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mauritania"),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: (tapPosition, point) {
            print(point.longitude);
          },
          onMapEvent: (p0) {
            p0.camera;
          },
          center: const LatLng(17.996309, -15.968650),
          zoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'http://172.20.10.5:8080/geoserver/test/wms?service=WMS&version=1.1.0&request=GetMap&layers=test%3Agadm36_MRT_2&bbox=-17.06652069091797%2C14.71555137634283%2C-4.827673912048283%2C27.298070907592773&width=256&height=256&srs=EPSG:4326&format=image/png&transparent=true',
            additionalOptions: const {
              'transparent': 'true',
              'format': 'image/png',
            },
          ),
          const MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(17.996309, -15.968650),
                child: Icon(
                  Icons.local_gas_station,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
