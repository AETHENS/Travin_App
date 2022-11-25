import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/page/tiket/screen/detailtiket.dart';

class TiketWidget extends StatefulWidget {
  String destinasi,
      status,
      dipesan,
      pada_tanggal,
      metode,
      harga,
      id,
      jumlahorang;
  TiketWidget(
      {Key? key,
      required this.destinasi,
      required this.status,
      required this.dipesan,
      required this.pada_tanggal,
      required this.metode,
      required this.harga,
      required this.id,
      required this.jumlahorang})
      : super(key: key);

  @override
  State<TiketWidget> createState() => _TiketWidgetState();
}

class _TiketWidgetState extends State<TiketWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTiketPage(
                  wisata: widget.destinasi,
                  dibooking: widget.dipesan,
                  tanggal_dibooking: widget.pada_tanggal,
                  metodPembayaran: widget.metode,
                  jumlahorang: widget.jumlahorang,
                  tiketID: widget.id,
                  totalHarga: widget.harga,
                  status: widget.status),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(vertical: 20),
        // height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 16,
                            width: 12.76,
                            margin: EdgeInsets.only(right: 8),
                            child: SvgPicture.asset(
                                "assets/images/destinasi-logo.svg"),
                          ),
                          Text(
                            widget.destinasi,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 25,
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.status,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF62AF88)),
                          ),
                        )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFEDFEF4),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dipesan",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: colorValue.greytextColor),
                            ),
                            Text(
                              widget.dipesan,
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pada tanggal",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: colorValue.greytextColor),
                            ),
                            Text(
                              widget.pada_tanggal,
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Color(0xFFF9F9F9),
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
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 16),
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFEAEEF2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            widget.metode,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA6AFBA)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(
                          widget.harga,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
