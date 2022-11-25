import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/model/tiketmodel.dart';
import 'package:travin_app/ui/page/tiket/widget/tiketwidget.dart';
import 'package:http/http.dart' as http;

class TiketPage extends StatefulWidget {
  TiketPage({Key? key}) : super(key: key);

  @override
  State<TiketPage> createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage> {
  TiketModel? tiketModel;
  bool loadingbgproses = true;
  Future<void> getAlltiket() async {
    setState(() {
      loadingbgproses = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http
        .get(Uri.parse('https://travin.darfrure.my.id/api/tiket'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    setState(() {
      loadingbgproses = true;
    });
    print("Status Code : ${response.statusCode}");
    print(response.body);
    tiketModel = TiketModel.fromJson(json.decode(response.body.toString()));
  }

  @override
  void initState() {
    super.initState();
    getAlltiket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 75,
          title: Text(
            "Tiket Saya",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: loadingbgproses
              ? tiketModel!.data.length != 0
                  ? ListView.builder(
                      itemCount: tiketModel!.data.length,
                      itemBuilder: (context, index) {
                        return TiketWidget(
                            id: tiketModel!.data[index].id.toString(),
                            destinasi:
                                tiketModel!.data[index].tujuan.toString(),
                            status: tiketModel!.data[index].status.toString(),
                            dipesan: tiketModel!.data[index].dipesan.toString(),
                            pada_tanggal: tiketModel!.data[index].tanggalWisata
                                .toString(),
                            metode:
                                tiketModel!.data[index].metodeBayar.toString(),
                            harga: tiketModel!.data[index].harga.toString(),
                            jumlahorang:
                                tiketModel!.data[index].jmlOrang.toString());
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            'assets/lottie/notiket.json',
                            width: 300,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'Anda belum memesan tiket',
                            style: TextStyle(
                                fontSize: 14, color: colorValue.greytextColor),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/lottie/tiket.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                )),
        ));
  }
}
