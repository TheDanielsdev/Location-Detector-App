import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:location_detector/models/content.dart';
import 'package:location_detector/pages/home.dart';
import 'package:location_detector/pages/mainscreen.dart';
import 'package:location_detector/pages/onboarding.dart';
import 'package:location_detector/pages/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)),
      debugShowCheckedModeBanner: false,
      home: showHome ? MainScreen() : Onbording(),
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
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 150,
            ),
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
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            contents[i].image,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'CerebriSansPro-Regular',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Row(
                children: [
                  Container(),
                  const Spacer(),
                  Container(
                    height: 30,
                    // margin: const EdgeInsets.only(
                    //   left: 200,
                    //   bottom: 10,
                    // ),
                    width: 110,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () async {
                        if (currentIndex == contents.length - 1) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
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
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
        color: Colors.white,
      ),
    );
  }
}
