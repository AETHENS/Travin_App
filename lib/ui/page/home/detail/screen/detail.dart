import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/model/detailmodel.dart';
import 'package:travin_app/ui/page/home/detail/widget/panelwidget.dart';
import 'package:travin_app/ui/page/home/detail/widget/slideshow.dart';
import 'package:travin_app/ui/page/pesan/pesan.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  String id;
  DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailModel? detailModel;
  bool loadingbgproses = true;

  void getAlllistdestinasi() async {
    setState(() {
      loadingbgproses = false;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
        Uri.parse(
            "https://travin.darfrure.my.id/api/home/detail?id=${widget.id}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    print("Status Code : ${response.statusCode}");
    print(response.body);
    detailModel = DetailModel.fromJson(json.decode(response.body.toString()));

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

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height / 1.8;
    final panelHeightOpen = MediaQuery.of(context).size.height / 1.3;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return loadingbgproses
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: SlidingUpPanel(
                    minHeight: panelHeightClosed,
                    maxHeight: panelHeightOpen,
                    boxShadow: [],
                    body: SlideShow(
                      foto1: detailModel!.data![0].pf1.toString(),
                      foto2: detailModel!.data![0].pf2.toString(),
                      foto3: detailModel!.data![0].pf3.toString(),
                    ),
                    panelBuilder: (controller) => PanelWidget(
                      controller: controller,
                      nama: detailModel!.data![0].namaDestinasi.toString(),
                      kota: detailModel!.data![0].kota.toString(),
                      deskripsi: detailModel!.data![0].deskripsi.toString(),
                      provinsi: detailModel!.data![0].provinsi.toString(),
                      latitude: detailModel!.data![0].latitude.toString(),
                      longitude: detailModel!.data![0].longitude.toString(),
                      thumbMap: detailModel!.data![0].pfMap.toString(),
                      jumlahview: detailModel!.data![0].jmlView!.toString(),
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: screenWidth,
                    height: 90,
                    padding: EdgeInsets.fromLTRB(30, 17, 30, 17),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "price",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colorValue.greytextColor),
                            ),
                            Text(
                              'Rp ${int.parse(detailModel!.data![0].estimasiHarga!) / 1000000} juta',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorValue.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "/Orang",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colorValue.greytextColor),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PesanTiketPage(
                                      harga: int.parse(
                                          detailModel!.data![0].estimasiHarga!),
                                      namaWisata: detailModel!
                                          .data![0].namaDestinasi
                                          .toString()),
                                ));
                          },
                          child: Container(
                            height: 56,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorValue.primaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icontiket.svg',
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text("Pesan Tiket",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 30, top: 60),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: Icon(Icons.arrow_back_ios_rounded)),
                ),
              ],
            ),
          )
        : Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: LottieBuilder.asset(
                  'assets/lottie/plane.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
