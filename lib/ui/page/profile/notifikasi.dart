import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travin_app/common/color.dart';

class NotifikasiPage extends StatefulWidget {
  NotifikasiPage({Key? key}) : super(key: key);

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_rounded))),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 94.07,
                  width: 75,
                  child: SvgPicture.asset('assets/images/destinasi-logo.svg'),
                ),
                Text(
                  'Travin App',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifikasi",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Izinkan Aplikasi memberitahu anda ",
                            style: TextStyle(
                                fontSize: 10, color: colorValue.greytextColor),
                          )
                        ],
                      ),
                      Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Color(0xFFB3CEF6),
                        activeColor: colorValue.primaryColor,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  'Version 1.0.0',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 12, color: colorValue.greytextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
