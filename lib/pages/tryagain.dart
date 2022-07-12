import 'package:flutter/material.dart';
import 'package:location_detector/pages/mainscreen.dart';

import '../models/map_class.dart';

class TryAgainPage extends StatefulWidget {
  const TryAgainPage({Key? key}) : super(key: key);

  @override
  State<TryAgainPage> createState() => _TryAgainPageState();
}

class _TryAgainPageState extends State<TryAgainPage> {
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 248, 191, 115),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text('No internet',
                  style: TextStyle(
                      fontFamily: 'CerebriSansPro-Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            Image.asset(
              'assets/nothing.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: isWaiting
                  ? null
                  : () {
                      // MapClass.map.addAll({"One": 1});
                      // MapClass.map.addAll({'Name': "Dan"});
                      // final check = MapClass.map.containsKey('Name');
                      // print(MapClass.map);
                      // print(check);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MainScreen()));
                      setState(() {
                        isWaiting = true;
                      });
                    },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: isWaiting
                        ? Colors.orange.withOpacity(0.5)
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: isWaiting
                      ? _circularProgressindicator()
                      : const Text('Try again',
                          style: const TextStyle(
                              fontFamily: 'CerebriSansPro-Regular',
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _circularProgressindicator extends StatelessWidget {
  const _circularProgressindicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.orange,
      color: Color.fromARGB(255, 248, 191, 115),
      value: 3,
      strokeWidth: 5,
    );
  }
}
