import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/icon_park_twotone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:iconify_flutter/iconify_flutter.dart'; // For Iconify Widget
import 'package:travin_app/ui/model/destinasimodel.dart';
import 'package:travin_app/ui/model/profileModel.dart';
import 'package:travin_app/ui/page/home/widget/loadingcard.dart';
import 'package:travin_app/ui/page/home/widget/loadingpopuler.dart';
import 'package:travin_app/ui/page/home/widget/populerlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travin_app/ui/page/home/widget/semualist.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ProfileModel? profileModel;
  DestinasiModel? destinasiModel;
  bool loadingbgproses = true;

  void getAlllistdestinasi() async {
    setState(() {
      loadingbgproses = false;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final res = await http
        .get(Uri.parse("https://travin.darfrure.my.id/api/home"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final resme = await http
        .get(Uri.parse("https://travin.darfrure.my.id/api/me"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print("Status Code Destinasi : ${res.statusCode}");
    print(res.body);
    destinasiModel = DestinasiModel.fromJson(json.decode(res.body.toString()));

    print("Status Code Profile : ${resme.statusCode}");
    print(resme.body);
    profileModel = ProfileModel.fromJson(json.decode(resme.body.toString()));

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

  TextEditingController controllersearch = TextEditingController();

  List<AllDestinasi> _search = [];
  onSearch(String text) async {
    setState(() {
      _search.clear();
      if (text.isEmpty) {
        return;
      }
      destinasiModel!.allDestinasi.forEach((f) {
        if (f.nama.toLowerCase().contains(text) ||
            f.id.toString().contains(text)) _search.add(f);
      });
    });
  }

  String wordsCapitalize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 1150,
          padding: EdgeInsets.only(left: 30, top: 56, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loadingbgproses
                  ? Text(
                      "Hi, ${wordsCapitalize(profileModel!.data.name)}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  : Text(
                      "Hi, User",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
              Text(
                "Kemana tujuanmu selanjutnya?",
                style: TextStyle(fontSize: 12, color: colorValue.greytextColor),
              ),
              Container(
                  padding: EdgeInsets.only(left: 19),
                  margin: EdgeInsets.only(top: 16, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    onTap: () {
                      controllersearch.clear();
                      onSearch('');
                    },
                    onChanged: onSearch,
                    controller: controllersearch,
                    decoration: InputDecoration(
                        icon: Iconify(IconParkTwotone.search,
                            color: Colors.blue.shade400),
                        border: InputBorder.none,
                        hintText: 'Cari Destinasi...',
                        hintStyle: TextStyle(
                            fontSize: 14, color: colorValue.greytextColor)),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    labelPadding: EdgeInsets.symmetric(horizontal: 5),
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0xff9B9B9B),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BubbleTabIndicator(
                      indicatorHeight: 33,
                      indicatorColor: Color(0xffE4EBF5),
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      indicatorRadius: 100,
                    ),
                    tabs: [
                      Container(
                        height: 33,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffECEEF2))),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                'Semua',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 33,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffECEEF2))),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                height: 16,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/temple.png'))),
                            Text(
                              'Candi',
                              style: TextStyle(
                                  fontSize: 10, fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 33,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffECEEF2))),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                height: 16,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/mountain.png'))),
                            Text(
                              'Gunung',
                              style: TextStyle(
                                  fontSize: 10, fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 33,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffECEEF2))),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                height: 16,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/island.png'))),
                            Text(
                              'Pantai',
                              style: TextStyle(
                                  fontSize: 10, fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 33,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffECEEF2))),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                height: 16,
                                child: Image(
                                    image:
                                        AssetImage('assets/images/lake.png'))),
                            Text(
                              'Danau',
                              style: TextStyle(
                                  fontSize: 10, fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.zero,
                  height: 225,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(controller: _tabController, children: [
                    loadingbgproses
                        ? Container(
                            child: _search.length != 0 ||
                                    controllersearch.text.isNotEmpty
                                ? ListView.builder(
                                    itemCount: _search.length,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, int index) {
                                      final b = _search[index];
                                      return SemuaList(
                                        id: b.id,
                                        nama: b.nama.toString(),
                                        provinsi: b.provinsi.toString(),
                                        pf_thumbnail: b.pfThumbnail.toString(),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        destinasiModel!.allDestinasi.length,
                                    itemBuilder: (context, index) {
                                      return SemuaList(
                                        id: destinasiModel!
                                            .allDestinasi[index].id,
                                        nama: destinasiModel!
                                            .allDestinasi[index].nama
                                            .toString(),
                                        provinsi: destinasiModel!
                                            .allDestinasi[index].provinsi
                                            .toString(),
                                        pf_thumbnail: destinasiModel!
                                            .allDestinasi[index].pfThumbnail
                                            .toString(),
                                      );
                                    },
                                  ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const LoadingCard();
                            },
                          ),
                    loadingbgproses
                        ? ListView.builder(
                            itemCount: destinasiModel!.wisataCandi.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return SemuaList(
                                id: destinasiModel!.wisataCandi[index].id
                                    .toString(),
                                nama: destinasiModel!.wisataCandi[index].nama
                                    .toString(),
                                provinsi: destinasiModel!
                                    .wisataCandi[index].provinsi
                                    .toString(),
                                pf_thumbnail: destinasiModel!
                                    .wisataCandi[index].pfThumbnail
                                    .toString(),
                              );
                            },
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const LoadingCard();
                            },
                          ),
                    loadingbgproses
                        ? ListView.builder(
                            itemCount: destinasiModel!.wisataGunung.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return SemuaList(
                                id: destinasiModel!.wisataGunung[index].id
                                    .toString(),
                                nama: destinasiModel!.wisataGunung[index].nama
                                    .toString(),
                                provinsi: destinasiModel!
                                    .wisataGunung[index].provinsi
                                    .toString(),
                                pf_thumbnail: destinasiModel!
                                    .wisataGunung[index].pfThumbnail
                                    .toString(),
                              );
                            },
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const LoadingCard();
                            },
                          ),
                    loadingbgproses
                        ? ListView.builder(
                            itemCount: destinasiModel!.wisataPantai.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return SemuaList(
                                id: destinasiModel!.wisataPantai[index].id
                                    .toString(),
                                nama: destinasiModel!.wisataPantai[index].nama
                                    .toString(),
                                provinsi: destinasiModel!
                                    .wisataPantai[index].provinsi
                                    .toString(),
                                pf_thumbnail: destinasiModel!
                                    .wisataPantai[index].pfThumbnail
                                    .toString(),
                              );
                            },
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const LoadingCard();
                            },
                          ),
                    loadingbgproses
                        ? ListView.builder(
                            itemCount: destinasiModel!.wisataDanau.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return SemuaList(
                                id: destinasiModel!.wisataDanau[index].id
                                    .toString(),
                                nama: destinasiModel!.wisataDanau[index].nama
                                    .toString(),
                                provinsi: destinasiModel!
                                    .wisataDanau[index].provinsi
                                    .toString(),
                                pf_thumbnail: destinasiModel!
                                    .wisataDanau[index].pfThumbnail
                                    .toString(),
                              );
                            },
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const LoadingCard();
                            },
                          ),
                  ])),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  "Populer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: loadingbgproses
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return PopulerList(
                              id: destinasiModel!.destinasiPopuler[index].id
                                  .toString(),
                              nama: destinasiModel!.destinasiPopuler[index].nama
                                  .toString(),
                              provinsi: destinasiModel!
                                  .destinasiPopuler[index].provinsi,
                              jumlahView: destinasiModel!
                                  .destinasiPopuler[index].jmlView
                                  .toString(),
                              harga: destinasiModel!
                                  .destinasiPopuler[index].estimasiHarga
                                  .toString(),
                              image: destinasiModel!
                                  .destinasiPopuler[index].pfThumbnail);
                        },
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return LoadingPopulerList();
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
