import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;

  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    super.dispose();
  }

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 1);

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: true,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await currentLocation();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));
          markers.clear();
          markers.add(Marker(
              markerId: const MarkerId(
                'Current Location',
              ),
              position: LatLng(position.latitude, position.longitude)));
          setState(() {});
        },
        label: const Text('Find Me',
            style: TextStyle(
                fontFamily: 'CerebriSansPro-Regular',
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        icon: const Icon(
          Icons.location_history,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<Position> currentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
