import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/page/pesan/succesnotification.dart';

class PesanTiketPage extends StatefulWidget {
  int harga;
  String namaWisata;
  PesanTiketPage({Key? key, required this.harga, required this.namaWisata})
      : super(key: key);

  @override
  State<PesanTiketPage> createState() => _PesanTiketPageState();
}

class _PesanTiketPageState extends State<PesanTiketPage> {
  int hargaAkhir = 0;
  String statusbayar = 'Belum Bayar';
  DateTime _dateTime = DateTime.now().add(new Duration(days: 7));
  DateTime dateNow = DateTime.now();
  // String formatTanggal =
  //     DateFormat.yMMMMd('yyyy-MM-dd – kk:mm').format(_dateTime);
  void _bukaCalendar() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().add(new Duration(days: 7)),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  //
  List<String> items = ['Transfer', 'Cash'];

  String? selecteditem = 'Transfer';
  TextEditingController ctrjumlahOrang = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hargaAkhir = widget.harga;
    if (selecteditem == 'Transfer') {
      statusbayar = 'Terbayar';
    } else {}
  }

  int jumlahOrang = 1;

  postData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    var response = await http.post(
        Uri.parse("https://travin.darfrure.my.id/api/tiket/create"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "tujuan": "${widget.namaWisata}",
          "dipesan": "${DateFormat.yMMMMd('id').format(dateNow)}",
          "tanggal_wisata": "${DateFormat.yMMMMd('id').format(_dateTime)}",
          "status": "${statusbayar}",
          "jml_orang": "${ctrjumlahOrang.text}",
          "metode_bayar": "${selecteditem}",
          "harga": "Rp ${hargaAkhir / 1000000} juta",
        });
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
                image: 'assets/images/verified.png',
                heading: 'Tiket Berhasil Dipesan',
                subheading: 'Tiket telah ditambahkan ke pemesanan',
              )));
    } else {
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
                heading: 'Tiket Gagal Dipesan',
                subheading:
                    'Tiket gagal ditambahkan ke pesanan, Silahkan coba lagi',
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    String nyiba = '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}';

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            SafeArea(
                top: true,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Iconify(
                        Bi.arrow_left,
                        size: 27,
                      )),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 94.07,
                  width: 75,
                  child: SvgPicture.asset('assets/images/destinasi-logo.svg'),
                ),
                Text(
                  widget.namaWisata,
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 48),
                  decoration: BoxDecoration(
                      border: Border.all(color: colorValue.outlineColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Wisata',
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          _bukaCalendar();
                        },
                        child: Container(
                          height: 48,
                          margin: EdgeInsets.only(top: 8, bottom: 16),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: colorValue.outlineColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 14, left: 16),
                                child: SvgPicture.asset(
                                    "assets/images/radix-icons_calendar.svg"),
                              ),
                              Text(
                                DateFormat.yMMMMd('id').format(_dateTime),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorValue.greytextColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 12),
                      ),
                      Container(
                        height: 48,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorValue.outlineColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: ctrjumlahOrang,
                          style: TextStyle(fontSize: 12),
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 17),
                              border: InputBorder.none,
                              hintText: "Jumlah orang",
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: colorValue.greytextColor)),
                          onChanged: (text) {
                            setState(() {
                              if (ctrjumlahOrang.text.isEmpty) {
                                jumlahOrang != 1;
                                hargaAkhir = widget.harga;
                              } else if (ctrjumlahOrang.text.isNotEmpty) {
                                jumlahOrang = int.parse(ctrjumlahOrang.text);
                                hargaAkhir = widget.harga * jumlahOrang;
                              } else {
                                hargaAkhir = widget.harga;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 48,
                        width: screenWidth,
                        padding: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorValue.outlineColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id', symbol: 'IDR  ')
                                  .format(hargaAkhir),
                              // "IDR ${hargaAkhir}",
                              style: TextStyle(fontSize: 12),
                            )),
                      ),
                      Container(
                          height: 48,
                          margin: EdgeInsets.only(top: 8, bottom: 24),
                          width: screenWidth,
                          padding: EdgeInsets.only(left: 16, right: 8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: colorValue.outlineColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                value: selecteditem,
                                items: items
                                    .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(fontSize: 12),
                                        )))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                      selecteditem = item;
                                      if (selecteditem == 'Transfer') {
                                        statusbayar = 'Terbayar';
                                      } else if (selecteditem == 'Cash') {
                                        statusbayar = 'Belum Bayar';
                                      } else if (selecteditem == null) {
                                        statusbayar = 'Terbayar';
                                      }
                                    })),
                          )),
                      GestureDetector(
                        onTap: () {
                          if (ctrjumlahOrang.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Isi Kolom Terlebih dahulu")));
                          } else if (ctrjumlahOrang.text.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Pesan tiket?',
                                  style: TextStyle(fontSize: 14),
                                ),
                                content: Text(
                                  'Apakah anda yakin ingin memesan tiket sekarang?',
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
                                        postData();
                                      },
                                      child: Text('Pesan'))
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 48,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colorValue.primaryColor),
                          child: Center(
                            child: Text(
                              'Pesan tiket',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
