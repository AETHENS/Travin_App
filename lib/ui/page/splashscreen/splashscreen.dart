import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/bottomtab.dart';
import 'package:travin_app/ui/page/intro/screen/introapp.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    Timer(Duration(seconds: 5), () {
      if (token != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ));
      } else if (token == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => IntroApp(),
            ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/destinasi-logo.svg'),
              SizedBox(
                height: 16,
              ),
              Text(
                "Travin App",
                style: TextStyle(fontSize: 20, color: Color(0xFFCDCDCD)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
