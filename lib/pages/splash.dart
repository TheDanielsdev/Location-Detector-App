import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'onboarding.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // Timer(
    //     const Duration(seconds: 5),
    //     () => Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (_) => Onbording())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => Onboarding()));
    // });
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            color: Colors.yellow,
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          Positioned.fill(
            child: Container(
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 4.0,
                      image: AssetImage(
                        'assets/map.png',
                      ))),
            ),
          ),
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    ));
  }
}
