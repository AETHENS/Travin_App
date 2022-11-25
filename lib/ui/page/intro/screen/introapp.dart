import 'package:flutter/material.dart';
import 'package:travin_app/bottomtab.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/page/intro/widget/animatedintro.dart';
import 'package:travin_app/ui/page/home/screen/home.dart';
import 'package:travin_app/ui/page/login/login.dart';
import 'package:travin_app/ui/page/register/screen/registrasi.dart';
import 'package:travin_app/ui/page/intro/widget/sliderintro.dart';

class IntroApp extends StatefulWidget {
  IntroApp({Key? key}) : super(key: key);

  @override
  State<IntroApp> createState() => _IntroAppState();
}

class _IntroAppState extends State<IntroApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            StartPage(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 110, right: 95),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jelajahi Indonesia",
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "Kami travlin siap membantu Anda berlibur keliling Indonesia",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         margin: EdgeInsets.only(right: 8),
                  //         height: 5,
                  //         width: 25,
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(20)),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.only(right: 8),
                  //         height: 5,
                  //         width: 25,
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(20)),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.only(right: 8),
                  //         height: 5,
                  //         width: 25,
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(20)),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 24, 30, 0),
                    margin: EdgeInsets.only(top: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrasiPage(),
                                ));
                          }),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Color(0xFF1B1B1B),
                                // color: colorValue.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Jelajahi Sekarang!",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun? ",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(
                                    0xFF9B9B9B,
                                  ),
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF498DF1),
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
