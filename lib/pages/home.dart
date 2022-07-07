// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

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
  late StreamSubscription internetSubscription;
  bool wait = false;
  bool isInternetOn = false;

  @override
  void initState() {
    // to read the user connection immediately the app fires.
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final isInternetOn = status == InternetConnectionStatus.connected;
      setState(() => this.isInternetOn = isInternetOn);
    });
    // to read the user connection immediately the app fires.

    checkConnectionState();
    //The interceptor function

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    internetSubscription.cancel();
    super.dispose();
  }

//I intercepted user network and show if theres internet or not. If there's no intrnet, the map won't work

  //I intercepted user network and show if theres internet or not. If there's no intrnet, the map won't work

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
        onPressed: _FindMeBtn, //the onPressed function
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

//I intercepted user network and show if theres internet or not. If there's no intrnet, the map won't work
  // ignore: non_constant_identifier_names
  void _FindMeBtn() async {
    var hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text(
          'Connection established',
          style: TextStyle(
              fontFamily: 'CerebriSansPro-Regular',
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ));
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(
          'No connection',
          style: TextStyle(
              fontFamily: 'CerebriSansPro-Regular',
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ));
    }
    //I intercepted user network and show if theres internet or not. If there's no intrnet, the map won't work
  }

  checkConnectionState() {}
}
