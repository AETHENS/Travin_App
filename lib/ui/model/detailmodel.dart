class DetailModel {
  String? status;
  String? message;
  List<Data>? data;

  DetailModel({this.status, this.message, this.data});

  DetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? idDestinasi;
  String? namaDestinasi;
  String? kota;
  String? provinsi;
  String? pf1;
  String? pf2;
  String? pf3;
  String? pfMap;
  String? deskripsi;
  String? jmlView;
  String? estimasiHarga;
  String? longitude;
  String? latitude;

  Data(
      {this.id,
      this.idDestinasi,
      this.namaDestinasi,
      this.kota,
      this.provinsi,
      this.pf1,
      this.pf2,
      this.pf3,
      this.pfMap,
      this.deskripsi,
      this.jmlView,
      this.estimasiHarga,
      this.longitude,
      this.latitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idDestinasi = json['id_destinasi'];
    namaDestinasi = json['nama_destinasi'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    pf1 = json['pf_1'];
    pf2 = json['pf_2'];
    pf3 = json['pf_3'];
    pfMap = json['pf_map'];
    deskripsi = json['deskripsi'];
    jmlView = json['jml_view'];
    estimasiHarga = json['estimasi_harga'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_destinasi'] = this.idDestinasi;
    data['nama_destinasi'] = this.namaDestinasi;
    data['kota'] = this.kota;
    data['provinsi'] = this.provinsi;
    data['pf_1'] = this.pf1;
    data['pf_2'] = this.pf2;
    data['pf_3'] = this.pf3;
    data['pf_map'] = this.pfMap;
    data['deskripsi'] = this.deskripsi;
    data['jml_view'] = this.jmlView;
    data['estimasi_harga'] = this.estimasiHarga;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
