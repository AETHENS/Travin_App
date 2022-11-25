// To parse this JSON data, do
//
//     final destinasiModel = destinasiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DestinasiModel destinasiModelFromJson(String str) =>
    DestinasiModel.fromJson(json.decode(str));

String destinasiModelToJson(DestinasiModel data) => json.encode(data.toJson());

class DestinasiModel {
  DestinasiModel({
    required this.status,
    required this.message,
    required this.allDestinasi,
    required this.destinasiPopuler,
    required this.wisataGunung,
    required this.wisataDanau,
    required this.wisataPantai,
    required this.wisataCandi,
  });

  String status;
  String message;
  List<AllDestinasi> allDestinasi;
  List<AllDestinasi> destinasiPopuler;
  List<Wisata> wisataGunung;
  List<Wisata> wisataDanau;
  List<Wisata> wisataPantai;
  List<Wisata> wisataCandi;

  factory DestinasiModel.fromJson(Map<String, dynamic> json) => DestinasiModel(
        status: json["status"],
        message: json["message"],
        allDestinasi: List<AllDestinasi>.from(
            json["all_destinasi"].map((x) => AllDestinasi.fromJson(x))),
        destinasiPopuler: List<AllDestinasi>.from(
            json["destinasi_populer"].map((x) => AllDestinasi.fromJson(x))),
        wisataGunung: List<Wisata>.from(
            json["wisata_gunung"].map((x) => Wisata.fromJson(x))),
        wisataDanau: List<Wisata>.from(
            json["wisata_danau"].map((x) => Wisata.fromJson(x))),
        wisataPantai: List<Wisata>.from(
            json["wisata_pantai"].map((x) => Wisata.fromJson(x))),
        wisataCandi: List<Wisata>.from(
            json["wisata_candi"].map((x) => Wisata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "all_destinasi":
            List<dynamic>.from(allDestinasi.map((x) => x.toJson())),
        "destinasi_populer":
            List<dynamic>.from(destinasiPopuler.map((x) => x.toJson())),
        "wisata_gunung":
            List<dynamic>.from(wisataGunung.map((x) => x.toJson())),
        "wisata_danau": List<dynamic>.from(wisataDanau.map((x) => x.toJson())),
        "wisata_pantai":
            List<dynamic>.from(wisataPantai.map((x) => x.toJson())),
        "wisata_candi": List<dynamic>.from(wisataCandi.map((x) => x.toJson())),
      };
}

class AllDestinasi {
  AllDestinasi({
    required this.id,
    required this.nama,
    required this.kota,
    required this.provinsi,
    required this.jenisWisata,
    required this.pfThumbnail,
    required this.jmlView,
    required this.estimasiHarga,
  });

  String id;
  String nama;
  String kota;
  String provinsi;
  JenisWisata? jenisWisata;
  String pfThumbnail;
  String jmlView;
  String estimasiHarga;

  factory AllDestinasi.fromJson(Map<String, dynamic> json) => AllDestinasi(
        id: json["id"],
        nama: json["nama"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        jenisWisata: jenisWisataValues.map[json["jenis_wisata"]],
        pfThumbnail: json["pf_thumbnail"],
        jmlView: json["jml_view"],
        estimasiHarga: json["estimasi_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kota": kota,
        "provinsi": provinsi,
        "jenis_wisata": jenisWisataValues.reverse[jenisWisata],
        "pf_thumbnail": pfThumbnail,
        "jml_view": jmlView,
        "estimasi_harga": estimasiHarga,
      };
}

enum JenisWisata { CANDI, PANTAI, GUNUNG, DANAU }

final jenisWisataValues = EnumValues({
  "candi": JenisWisata.CANDI,
  "danau": JenisWisata.DANAU,
  "gunung": JenisWisata.GUNUNG,
  "pantai": JenisWisata.PANTAI
});

class Wisata {
  Wisata({
    required this.id,
    required this.nama,
    required this.kota,
    required this.provinsi,
    required this.jenisWisata,
    required this.pfThumbnail,
    required this.jmlView,
    required this.estimasiHarga,
  });

  int id;
  String nama;
  String kota;
  String provinsi;
  JenisWisata? jenisWisata;
  String pfThumbnail;
  String jmlView;
  String estimasiHarga;

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
        id: json["id"],
        nama: json["nama"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        jenisWisata: jenisWisataValues.map[json["jenis_wisata"]],
        pfThumbnail: json["pf_thumbnail"],
        jmlView: json["jml_view"],
        estimasiHarga: json["estimasi_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kota": kota,
        "provinsi": provinsi,
        "jenis_wisata": jenisWisataValues.reverse[jenisWisata],
        "pf_thumbnail": pfThumbnail,
        "jml_view": jmlView,
        "estimasi_harga": estimasiHarga,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
