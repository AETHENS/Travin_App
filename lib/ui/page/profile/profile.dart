import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/model/profileModel.dart';
import 'package:travin_app/ui/page/intro/screen/introapp.dart';
import 'package:http/http.dart' as http;
import 'package:travin_app/ui/page/profile/editprofile.dart';
import 'package:travin_app/ui/page/profile/notifikasi.dart';
import 'package:travin_app/ui/page/profile/tentangaplikasi.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Widget iconteks(Iconify iconnya, String teksnya) {
  return Container(
    margin: EdgeInsets.only(bottom: 24),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 24,
          ),
          height: 24,
          width: 24,
          child: iconnya,
        ),
        Text(
          teksnya,
          style: TextStyle(fontSize: 14),
        )
      ],
    ),
  );
}

Widget iconteks2(String iconnya, String teksnya) {
  return Container(
    margin: EdgeInsets.only(bottom: 24),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 24,
          ),
          height: 24,
          width: 24,
          child: SvgPicture.asset(iconnya),
        ),
        Text(
          teksnya,
          style: TextStyle(fontSize: 14),
        )
      ],
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel? profileModel;
  bool loadingbgproses = true;

  Future getAlllistdestinasi() async {
    setState(() {
      loadingbgproses = false;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http
        .get(Uri.parse("https://travin.darfrure.my.id/api/me"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print("Status Code : ${response.statusCode}");
    print(response.body);
    profileModel = ProfileModel.fromJson(json.decode(response.body.toString()));

    setState(() {
      loadingbgproses = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlllistdestinasi();
  }

  String wordsCapitalize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return loadingbgproses
        ? RefreshIndicator(
            onRefresh: getAlllistdestinasi,
            child: Scaffold(
                body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: screenWidth,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/defaultavatar.jpg',
                              image:
                                  'https://travin.darfrure.my.id/storage/${profileModel!.data.avatar}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          wordsCapitalize(profileModel!.data.name),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          profileModel!.data.email,
                          style: TextStyle(
                              fontSize: 12, color: colorValue.greytextColor),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                      username: profileModel!.data.name,
                                      imageAPI: profileModel!.data.avatar,
                                      email: profileModel!.data.email,
                                    ),
                                  ));
                            },
                            child: iconteks(
                                Iconify(MaterialSymbols.edit_outline_rounded),
                                "Edit Profile")),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotifikasiPage(),
                                  ));
                            },
                            child: iconteks2(
                                'assets/images/notificon.svg', 'Notifikasi')),
                        iconteks2(
                            'assets/images/transaksi.svg', 'Berkas Transaksi'),
                        iconteks2("assets/images/faq2.svg", 'FAQ'),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TentangAplikasiPage(),
                                  ));
                            },
                            child: iconteks2(
                                'assets/images/info2.svg', "Tentang Aplikasi")),
                        GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Keluar',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  content: Text(
                                    'Apakah anda yakin ingin dari keluar akun',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Tidak')),
                                    TextButton(
                                        onPressed: () async {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          await pref.clear();

                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        IntroApp(),
                                                  ),
                                                  (route) => false);
                                          print('Berhasil Keluar dari akun');
                                        },
                                        child: Text('iya'))
                                  ],
                                ),
                              );
                            },
                            child: iconteks2(
                                'assets/images/logouticon.svg', 'Keluar')),
                        SizedBox(height: screenHeight / 3)
                      ],
                    ),
                  ),
                ),
              ),
            )),
          )
        : Center(
            child: LottieBuilder.asset(
              'assets/lottie/plane.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          );
  }
}
