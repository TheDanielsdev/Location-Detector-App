import 'package:flutter/material.dart';
import 'package:location_detector/pages/home.dart';
import 'package:location_detector/pages/mainscreen.dart';
import 'package:location_detector/pages/onboarding.dart';
import 'package:location_detector/pages/settings.dart';
import 'package:location_detector/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primarySwatch: ThemeData(C)
          ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // initialRoute:
      //     initScreen == 0 || initScreen == null ? 'onboard_screen' : 'home',
      // routes: {
      //   'home': (context) => MainScreen(),
      //   'onboarding_screen': (context) => Onbording(),
      // },
    );
  }
}


// AIzaSyAhnbBaB95YNV3RcNM_blCnSABGsNQkGhg