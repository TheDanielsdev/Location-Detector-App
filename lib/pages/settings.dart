// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location_detector/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //for sharedpreferences to save the state
  static const switchKey = 'SwitchKey';
  late bool changed = false;
  //for sharedpreferences to save the state

  var lat, long;
  // bool state = false;
  bool isChangeTheme = false;
  final IconData _lightIcon = Icons.sunny;
  final IconData _darkIcon = Icons.nights_stay;
  final ThemeData _light =
      ThemeData(accentColor: Colors.orange, brightness: Brightness.dark);
  final ThemeData _dark =
      ThemeData(accentColor: Colors.orange, brightness: Brightness.light);
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
  void initState() {
    restoreFnc();
    super.initState();
  }

//The first function to Read a value from persistent storage, using SharePrefernce, which I called above in the init state
  void restoreFnc() async {
    var preferences = await SharedPreferences.getInstance();
    var changed = preferences.getBool(switchKey);
    //this change variable (this.chnaged) is the same one I defined up above with: late bool changed
    setState(() => this.changed = changed!);
  }

//The second function to save to persistent storage in the background using sharePreference.,
  void persistFnc() async {
    setState(() => changed = !changed);
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(switchKey, changed);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isChangeTheme ? _dark : _light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 191, 115),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isChangeTheme = !isChangeTheme;
                  });
                },
                icon: Icon(
                  isChangeTheme ? _darkIcon : _lightIcon,
                  color: isChangeTheme ? Colors.white : Colors.black,
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
                          fontSize: 15,
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
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ListTile(
                    title: changed
                        ? const Text('',
                            style: TextStyle(
                                fontFamily: 'CerebriSansPro-Regular',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold))
                        : const Text('Read my location',
                            style: TextStyle(
                                fontFamily: 'CerebriSansPro-Regular',
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                    trailing: Wrap(
                      spacing: 0,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              changed
                                  ? Text('latitude: $lat',
                                      style: const TextStyle(
                                          fontFamily: 'CerebriSansPro-Regular',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))
                                  : const Text(''),
                              const SizedBox(
                                height: 5,
                              ),
                              changed
                                  ? Text('longitude: $long',
                                      style: const TextStyle(
                                          fontFamily: 'CerebriSansPro-Regular',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))
                                  : const Text(''),
                            ],
                          ),
                        ),
                        Switch(
                            activeTrackColor: Colors.orange,
                            inactiveThumbColor: Colors.grey[800],
                            thumbColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.orange.withOpacity(.48);
                              }
                              return Colors.orange;
                            }),
                            value: changed,
                            onChanged: (bool s) {
                              persistFnc();

                              setState(() {
                                changed = s;
                                print(changed);
                              });
                              changed == true ? getLocation() : null;
                            }),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ListTile(
                    onTap: () {},
                    title: const Text('Privacy policy',
                        style: TextStyle(
                            fontFamily: 'CerebriSansPro-Regular',
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: isChangeTheme ? Colors.white : Colors.black,
                    )),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Text('Location Detector',
                    style: TextStyle(
                        fontFamily: 'CerebriSansPro-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Text('V1.0',
                    style: TextStyle(
                        fontFamily: 'CerebriSansPro-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Text('TheDaniels Team',
                    style: TextStyle(
                        fontFamily: 'CerebriSansPro-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Text('Copyright 2022',
                    style: TextStyle(
                        fontFamily: 'CerebriSansPro-Regular',
                        color: Colors.blueGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
