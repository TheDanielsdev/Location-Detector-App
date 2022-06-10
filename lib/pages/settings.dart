// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_detector/pages/home.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var lat, long;
  bool state = false;
  bool isChangeTheme = false;
  IconData _lightIcon = Icons.sunny;
  IconData _darkIcon = Icons.nights_stay;
  ThemeData _light =
      ThemeData(accentColor: Colors.red, brightness: Brightness.light);
  ThemeData _dark =
      ThemeData(accentColor: Colors.red, brightness: Brightness.dark);
  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isChangeTheme ? _dark : _light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isChangeTheme = !isChangeTheme;
                  });
                },
                icon: Icon(
                  isChangeTheme ? _darkIcon : _lightIcon,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text('Change Settings',
                      style: TextStyle(
                          fontFamily: 'CerebriSansPro-Regular',
                          fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                    title: state
                        ? Text('Read my location',
                            style: TextStyle(
                                fontFamily: 'CerebriSansPro-Regular',
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.2),
                                fontWeight: FontWeight.bold))
                        : const Text('Read my location',
                            style: TextStyle(
                                fontFamily: 'CerebriSansPro-Regular',
                                fontWeight: FontWeight.bold)),
                    trailing: Wrap(
                      spacing: 0,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              state
                                  ? Text('latitude: $lat',
                                      style: const TextStyle(
                                          fontFamily: 'CerebriSansPro-Regular',
                                          fontWeight: FontWeight.bold))
                                  : const Text(''),
                              const SizedBox(
                                height: 5,
                              ),
                              state
                                  ? Text('longitude: $long',
                                      style: const TextStyle(
                                          fontFamily: 'CerebriSansPro-Regular',
                                          fontWeight: FontWeight.bold))
                                  : const Text(''),
                            ],
                          ),
                        ),
                        Switch(
                            value: state,
                            onChanged: (bool s) {
                              setState(() {
                                state = s;
                                print(state);
                              });
                              state == true ? getLocation() : null;
                              // state == true
                              //     ? Navigator.of(context).push(
                              //         MaterialPageRoute(builder: (_) => Home()))
                              //     : null;
                            }),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                    title: Text('Privacy policy',
                        style: TextStyle(
                            fontFamily: 'CerebriSansPro-Regular',
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.black)),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Text('V1.0',
                    style: TextStyle(
                        fontFamily: 'CerebriSansPro-Regular',
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
