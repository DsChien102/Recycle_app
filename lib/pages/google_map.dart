import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  static LatLng _recycle = LatLng(20.961535, 105.747574);
  static LatLng _recycle1 = LatLng(20.960815, 105.756554);
  static LatLng _recycle2 = LatLng(20.962843, 105.752286);
  static LatLng _recycle3 = LatLng(20.961859, 105.745006);
  static LatLng _recycle4 = LatLng(20.965260, 105.744828);
  static LatLng _recycle5 = LatLng(20.959501, 105.752449);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _recycle, zoom: 14.0),
        markers: {
          Marker(
            markerId: MarkerId('current_location'),
            position: _recycle1,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(
              title: 'Recycling Center',
              snippet: "Location of the recycling center",
            ),
          ),
          Marker(
            markerId: MarkerId('custom_marker'),
            position: _recycle2,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(
              title: 'Recycling Center',
              snippet: "Location of the recycling center",
            ),
          ),
          Marker(
            markerId: MarkerId('custom_marker'),
            position: _recycle3,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(
              title: 'Recycling Center',
              snippet: "Location of the recycling center",
            ),
          ),
          Marker(
            markerId: MarkerId('custom_marker'),
            position: _recycle4,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(
              title: 'Recycling Center',
              snippet: "Location of the recycling center",
            ),
          ),
          Marker(
            markerId: MarkerId('custom_marker'),
            position: _recycle5,
            draggable: true,
            onDragEnd: (value) {},
            infoWindow: InfoWindow(
              title: 'Recycling Center',
              snippet: "Location of the recycling center",
            ),
          ),
        },
      ),
    );
  }
}
