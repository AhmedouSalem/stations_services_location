import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPageApp extends StatelessWidget {
  const MapPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Map with GeoServer')),
      body: FlutterMap(
        options: const MapOptions(),
        children: [
          TileLayer(
            urlTemplate:
                "http://172.20.10.5:8080/geoserver/test/wms?service=WMS&version=1.1.0&request=GetMap&layers=test%3Agadm36_MRT_2&bbox=-17.06652069091797%2C14.71555137634283%2C-4.827673912048283%2C27.298070907592773&width=256&height=256&srs=EPSG:4326&format=image/png&transparent=true",
            // subdomains: const ['a', 'b', 'c'],
            tileBuilder: (context, tileWidget, tile) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          // TileLayer(
          //   wmsOptions: WMSTileLayerOptions(
          //     baseUrl: "http://172.20.10.5:8080/geoserver/test/wms",
          //     layers: const ['test:gadm36_MRT_2'],
          //     format: 'image/png',
          //     transparent: true,
          //     version: '1.1.0',
          //     otherParameters: const {
          //       'service': 'WMS',
          //       'request': 'GetMap',
          //       'srs': 'EPSG:4326',
          //       'bbox':
          //           '-17.06652069091797,14.71555137634283,-4.827673912048283,27.298070907592773',
          //       'width': '800',
          //       'height': '800',
          //       'styles': '',
          //     },
          //   ),
          // ),
          const MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(17.996309, -15.968650),
                child: Icon(Icons.local_gas_station,
                    color: Colors.red, size: 40.0),
              ),
              // Add other markers here
            ],
          ),
        ],
      ),
    );
  }
}
