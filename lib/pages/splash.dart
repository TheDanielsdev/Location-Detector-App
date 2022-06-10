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
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Onbording())));
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
    return Container(
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 190, top: 70),
              child: Center(
                child: Image.asset(
                  'assets/map.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 0),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
