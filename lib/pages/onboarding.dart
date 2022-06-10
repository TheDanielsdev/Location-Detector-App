// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:location_detector/pages/home.dart';
import 'package:location_detector/pages/mainscreen.dart';

import '../models/content.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 500,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          contents[i].title,
                          style: const TextStyle(
                            fontFamily: 'CerebriSansPro-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Text(
                        //   contents[i].discription,
                        //   textAlign: TextAlign.center,
                        //   style: const TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.grey,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            padding: const EdgeInsetsDirectional.only(bottom: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(),
                Spacer(),
                Container(
                  height: 30,
                  margin: const EdgeInsets.only(
                    left: 200,
                    bottom: 10,
                  ),
                  width: 100,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainScreen(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: const Duration(seconds: 2),
                        curve: Curves.bounceOut,
                      );
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(currentIndex == contents.length - 1
                              ? "Finish"
                              : "Next"),
                          currentIndex == contents.length - 1
                              ? const Text('')
                              : const Icon(
                                  Icons.arrow_forward,
                                  size: 15,
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 5,
      width: currentIndex == index ? 15 : 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      ),
    );
  }
}
