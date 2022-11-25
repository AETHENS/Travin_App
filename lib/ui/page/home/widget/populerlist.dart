import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:intl/intl.dart';
import 'package:travin_app/common/color.dart';

import 'package:travin_app/ui/page/home/detail/screen/detail.dart';

class PopulerList extends StatefulWidget {
  String id, nama, provinsi, jumlahView, harga, image;

  PopulerList(
      {Key? key,
      required this.id,
      required this.nama,
      required this.provinsi,
      required this.jumlahView,
      required this.harga,
      required this.image})
      : super(key: key);

  @override
  State<PopulerList> createState() => _PopulerListState();
}

class _PopulerListState extends State<PopulerList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(id: widget.id),
            ));
      },
      child: Container(
        height: 145,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 30, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFECEEF2), width: 0.86),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 135,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loadthumb.png',
                  placeholderFit: BoxFit.fill,
                  image:
                      'https://travin.darfrure.my.id/storage/img_travel${widget.image}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: 180,
              margin: EdgeInsets.only(
                left: 16,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8, top: 4, bottom: 8),
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
                  Container(
                    width: 120,
                    child: Text(
                      "${widget.jumlahView} orang melihat tempat ini",
                      style: TextStyle(
                          fontSize: 10, color: colorValue.greytextColor),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 16, right: 16),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'IDR  ')
                              .format(int.parse(widget.harga)),
                          style: TextStyle(
                              fontSize: 10, color: colorValue.greytextColor),
                        ),
                        Text(
                          "/Orang",
                          style: TextStyle(
                              fontSize: 10, color: colorValue.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
