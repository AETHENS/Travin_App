import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travin_app/common/color.dart';

class TentangAplikasiPage extends StatefulWidget {
  TentangAplikasiPage({Key? key}) : super(key: key);

  @override
  State<TentangAplikasiPage> createState() => _TentangAplikasiPageState();
}

class _TentangAplikasiPageState extends State<TentangAplikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: SafeArea(
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
                  height: 64,
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
                  height: 24,
                ),
                Text(
                  'Aplikasi Travin dibuat  untuk  memenuhi tugas Mobile Programming sekaligus menambah portofolio developer, Aplikasi ini dibuat seolah olah seperti aplikasi sesungguhnya dan transaksi di aplikasi ini hanya dibuat seolah olah transaksi sungguhan, tidak ada transaksi asli di aplikasi ini!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 12, color: colorValue.greytextColor),
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
