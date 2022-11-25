// To parse this JSON data, do
//
//     final tiketModel = tiketModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TiketModel tiketModelFromJson(String str) =>
    TiketModel.fromJson(json.decode(str));

String tiketModelToJson(TiketModel data) => json.encode(data.toJson());

class TiketModel {
  TiketModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory TiketModel.fromJson(Map<String, dynamic> json) => TiketModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.tujuan,
    required this.dipesan,
    required this.tanggalWisata,
    required this.jmlOrang,
    required this.status,
    required this.metodeBayar,
    required this.harga,
  });

  String id;
  String userId;
  String tujuan;
  String dipesan;
  String tanggalWisata;
  String jmlOrang;
  String status;
  String metodeBayar;
  String harga;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        tujuan: json["tujuan"],
        dipesan: json["dipesan"],
        tanggalWisata: json["tanggal_wisata"],
        jmlOrang: json["jml_orang"],
        status: json["status"],
        metodeBayar: json["metode_bayar"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "tujuan": tujuan,
        "dipesan": dipesan,
        "tanggal_wisata": tanggalWisata,
        "jml_orang": jmlOrang,
        "status": status,
        "metode_bayar": metodeBayar,
        "harga": harga,
      };
}
