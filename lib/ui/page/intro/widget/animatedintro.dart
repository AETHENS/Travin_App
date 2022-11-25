import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  static const _images = <String>[
    'assets/images/introapp/1.png',
    'assets/images/introapp/2.png',
    'assets/images/introapp/5.png'
  ];

  Timer? timer;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 3500), (timer) {
      if (index < _images.length) {
        if (mounted) {
          setState(() {
            index++;
            print(index);
          });
        }
      }

      if (index == _images.length) {
        if (mounted) {
          setState(() {
            index = 0;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(fit: StackFit.passthrough, children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Image.asset(
              width: screenWidth,
              height: screenHeight,
              key: ValueKey(_images[index]),
              _images[index],
              fit: BoxFit.cover,
            ),
          ),
        ]),
      ),
    );
  }
}
