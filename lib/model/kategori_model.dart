// To parse this JSON data, do
//
//     final kategoriModel = kategoriModelFromJson(jsonString);

import 'dart:convert';

KategoriModel kategoriModelFromJson(String str) =>
    KategoriModel.fromJson(json.decode(str));

String kategoriModelToJson(KategoriModel data) => json.encode(data.toJson());

class KategoriModel {
  KategoriModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory KategoriModel.fromJson(Map<String, dynamic> json) => KategoriModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.namaKategori,
    this.jenis,
    this.icon,
  });

  int? id;
  String? namaKategori;
  int? jenis;
  String? icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        namaKategori:
            json["nama_kategori"] == null ? null : json["nama_kategori"],
        jenis: json["jenis"] == null ? null : json["jenis"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_kategori": namaKategori == null ? null : namaKategori,
        "jenis": jenis == null ? null : jenis,
        "icon": icon == null ? null : icon,
      };
}
