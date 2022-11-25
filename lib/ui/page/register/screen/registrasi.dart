import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/icon_park_twotone.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/bottomtab.dart';
import 'package:travin_app/ui/model/registerUserModel.dart';
import 'package:travin_app/ui/model/userModel.dart';
import 'package:travin_app/ui/page/login/login.dart';
import 'package:http/http.dart' as http;

class RegistrasiPage extends StatefulWidget {
  RegistrasiPage({Key? key}) : super(key: key);

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  bool _isVisible = false;

  //textfield username dan email
  Widget txtfield(String namatextfield, TextEditingController controllernya,
      Iconify iconnya) {
    return Container(
        height: 48,
        padding: EdgeInsets.only(left: 19),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Color(0xFFECEEF2))),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controllernya,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 12),
              border: InputBorder.none,
              icon: iconnya,
              hintText: namatextfield,
              hintStyle:
                  TextStyle(fontSize: 12, color: colorValue.greytextColor)),
        ));
  }

  //textfield password
  Widget txtfieldpw(String namatextfield, TextEditingController controllernya,
      Iconify iconnya) {
    return Container(
        height: 48,
        padding: EdgeInsets.only(left: 19),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Color(0xFFECEEF2))),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          obscureText: !_isVisible,
          controller: controllernya,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible
                      ? Icon(
                          Icons.visibility,
                          color: Color(0xFFC4C4C4),
                          size: 20,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Color(0xFFC4C4C4),
                          size: 20,
                        )),
              contentPadding: EdgeInsets.only(bottom: 3),
              border: InputBorder.none,
              icon: iconnya,
              hintText: namatextfield,
              hintStyle:
                  TextStyle(fontSize: 12, color: colorValue.greytextColor)),
        ));
  }

  TextEditingController ctrusername = new TextEditingController();
  TextEditingController ctremail = new TextEditingController();
  TextEditingController ctrpassword = new TextEditingController();

  // POST API
  postData() async {
    if (ctrusername.text.isNotEmpty &&
        ctremail.text.isNotEmpty &&
        ctrpassword.text.isNotEmpty) {
      var response = await http
          .post(Uri.parse("https://travin.darfrure.my.id/api/register"), body: {
        "name": "${ctrusername.text}",
        "email": "${ctremail.text}",
        "password": "${ctrpassword.text}"
      });
      print("Status Code : ${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        RegisterUserModel user = registerUserModelFromJson(response.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', user.accessToken);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email Sudah Terdaftar")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Isi Semua Kolom dengan benar")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 107,
                width: 85.31,
                margin: EdgeInsets.only(bottom: 40),
                child: SvgPicture.asset('assets/images/destinasi-logo.svg'),
              ),
              Text(
                "Registrasi akun",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Masukkan username dan password untuk mendaftarkan akun anda di Aplikasi Travin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: colorValue.greytextColor),
              ),
              SizedBox(
                height: 16,
              ),
              txtfield(
                  'Username',
                  ctrusername,
                  Iconify(
                    Ion.md_mail,
                    color: Color(
                      0xFF277FFE,
                    ),
                    size: 20,
                  )),
              txtfield(
                  'Email',
                  ctremail,
                  Iconify(
                    Ion.md_mail,
                    color: Color(0xFF277FFE),
                    size: 20,
                  )),
              txtfieldpw(
                  'Password',
                  ctrpassword,
                  Iconify(
                    Bi.shield_lock_fill,
                    color: Color(0xFF277FFE),
                    size: 16,
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  margin: EdgeInsets.only(top: 16),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ElevatedButton(
                      onPressed: postData,
                      child: Text("Sign in"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF277FFE),
                      ),
                    ),
                  )),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: colorValue.greytextColor),
                  ),
                  SizedBox(
                    width: 3,
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
                      "login",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: colorValue.primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
