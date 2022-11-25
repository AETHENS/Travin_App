import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/page/pesan/succesnotification.dart';
import 'package:http/http.dart ' as http;

class DetailTiketPage extends StatefulWidget {
  String wisata,
      dibooking,
      tanggal_dibooking,
      tiketID,
      jumlahorang,
      metodPembayaran,
      totalHarga,
      status;
  DetailTiketPage(
      {Key? key,
      required this.wisata,
      required this.dibooking,
      required this.tanggal_dibooking,
      required this.metodPembayaran,
      required this.tiketID,
      required this.jumlahorang,
      required this.totalHarga,
      required this.status})
      : super(key: key);

  @override
  State<DetailTiketPage> createState() => _DetailTiketPageState();
}

class _DetailTiketPageState extends State<DetailTiketPage> {
  Widget paketteks(String text10, String text12) {
    return Flexible(
      flex: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text10,
              style: TextStyle(fontSize: 10, color: colorValue.greytextColor),
            ),
            Text(
              text12,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  deleteData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    var response = await http.get(
        Uri.parse(
            'https://travin.darfrure.my.id/api/tiket/delete?id=${widget.tiketID}'),
        headers: {'Authorization': 'Bearer $token'});
    print("Status Code : ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showModalBottomSheet(
          isDismissible: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          isScrollControlled: false,
          context: context,
          builder: (context) => Container(
              height: 255,
              child: SuccesNotification(
                image: 'assets/images/ticket.png',
                heading: 'Tiket Berhasil Dibatalkan',
                subheading: 'Anda telah membatalkan pemesanan ini',
              )));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal, Silahkan coba lagi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //
    return Scaffold(
      backgroundColor: Color(0xFF2E5A9A),
      appBar: AppBar(
        title: Text(
          "Detail Tiket",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth,
                      // decoration: BoxDecoration(color: Colors.amber),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: 24,
                                  width: 19.14,
                                  child: SvgPicture.asset(
                                      'assets/images/destinasi-logo.svg'),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Travin'),
                                    Text(
                                      widget.wisata,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: colorValue.greytextColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 1,
                              width: screenWidth,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                paketteks('Di-Booking', widget.dibooking),
                                SizedBox(
                                  width: 60,
                                ),
                                paketteks('Tanggal Di-Booking',
                                    widget.tanggal_dibooking),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 1,
                              width: screenWidth,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                paketteks('Tujuan', widget.wisata),
                                SizedBox(
                                  width: 60,
                                ),
                                paketteks('Tiket ID', widget.tiketID),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                paketteks('Jumlah Orang', widget.jumlahorang),
                                SizedBox(
                                  width: 60,
                                ),
                                paketteks('Total Harga', widget.totalHarga),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                paketteks('Metode Pembayaran',
                                    widget.metodPembayaran),
                                SizedBox(
                                  width: 60,
                                ),
                                paketteks('Status Pembayaran', widget.status),
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: screenWidth,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xFF2E5A9A),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xFF2E5A9A),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 24),
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: screenWidth,
                      child: Text(
                        'travinid${widget.tiketID}',
                        style: TextStyle(fontSize: 48, fontFamily: 'BarCode'),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Batalkan tiket?',
                              style: TextStyle(fontSize: 14),
                            ),
                            content: Text(
                              'Apakah anda yakin ingin membatalkan pemesanan tiket ini?',
                              style: TextStyle(fontSize: 12),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Tidak')),
                              TextButton(
                                  onPressed: () {
                                    deleteData();
                                  },
                                  child: Text('iya'))
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorValue.dangerColor),
                        child: Center(
                          child: Text(
                            'Batalkan Tiket',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorValue.succesColor),
                        child: Center(
                          child: Text(
                            'Kembali',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
