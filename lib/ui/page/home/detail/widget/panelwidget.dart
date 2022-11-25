import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:travin_app/common/color.dart';
import 'package:travin_app/ui/page/home/detail/widget/gmaps.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  String nama,
      kota,
      provinsi,
      deskripsi,
      longitude,
      latitude,
      thumbMap,
      jumlahview;
  PanelWidget(
      {Key? key,
      required this.controller,
      required this.nama,
      required this.kota,
      required this.provinsi,
      required this.deskripsi,
      required this.longitude,
      required this.latitude,
      required this.thumbMap,
      required this.jumlahview})
      : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.bottomCenter,
      width: screenWidth,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 8, bottom: 16),
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0XFFD9D9D9)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.nama,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.jumlahview} Review",
                        style: TextStyle(
                            fontSize: 10, color: colorValue.greytextColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(right: 8, top: 4, bottom: 8),
                            child: Iconify(
                              Ep.location,
                              size: 12,
                              color: colorValue.greytextColor,
                            ),
                          ),
                          Text(
                            widget.provinsi,
                            style: TextStyle(
                                fontSize: 10, color: colorValue.greytextColor),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          MapUtils.openMap(widget.latitude, widget.longitude);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(right: 8, top: 4, bottom: 8),
                              child: Iconify(
                                Ep.location,
                                size: 12,
                                color: colorValue.primaryColor,
                              ),
                            ),
                            Text(
                              'Maps',
                              style: TextStyle(
                                  fontSize: 10, color: colorValue.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    height: 1,
                    width: screenWidth,
                    color: Color(0xFFC4C4C4),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      widget.deskripsi,
                      style: TextStyle(
                          fontSize: 10, color: colorValue.greytextColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Lokasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      MapUtils.openMap(widget.latitude, widget.longitude);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      height: 200,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loadmapsthumb.png',
                          image:
                              'https://travin.darfrure.my.id/storage/img_travel${widget.thumbMap}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
