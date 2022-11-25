import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:travin_app/ui/page/home/screen/home.dart';
import 'package:travin_app/ui/page/profile/profile.dart';
import 'package:travin_app/ui/page/tiket/screen/tiketsaya.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentindex = 0;
  final Screens = [HomePage(), TiketPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF498DF1),
          unselectedItemColor: Color(0xFFAAAAAA),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 24,
          elevation: 0,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: currentindex,
          onTap: (index) => setState(
                () => currentindex = index,
              ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_outlined),
              label: "Tiket Saya",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_rounded,
                ),
                label: "Profile"),
          ]),
    );
  }
}
