import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:travin_app/ui/model/destinasimodel.dart';
import 'package:travin_app/common/color.dart';
import 'package:http/http.dart' as http;
import 'package:travin_app/ui/page/home/detail/screen/detail.dart';

class SemuaList extends StatefulWidget {
  String nama, provinsi, pf_thumbnail, id;

  SemuaList({
    Key? key,
    required this.id,
    required this.nama,
    required this.provinsi,
    required this.pf_thumbnail,
  }) : super(key: key);

  @override
  State<SemuaList> createState() => _SemuaListState();
}

class _SemuaListState extends State<SemuaList> {
  DestinasiModel? destinasiModel;
  bool loadingbgproses = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(id: widget.id.toString()),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        width: 166,
        // height: 219,
        padding: EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFECEEF2)),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 152,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loadthumb.png',
                  image:
                      'https://travin.darfrure.my.id/storage/img_travel${widget.pf_thumbnail}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 125,
                      margin: EdgeInsets.only(bottom: 2),
                      child: Text(
                        widget.nama,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Iconify(
                            Ep.location,
                            size: 12,
                            color: colorValue.greytextColor,
                          ),
                        ),
                        Container(
                          // color: Colors.amber,
                          width: 94,
                          child: Text(
                            widget.provinsi,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10, color: colorValue.greytextColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Container(
                //   margin: EdgeInsets.only(right: 6),
                //   child: Icon(Icons.favorite, color: Colors.red),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
