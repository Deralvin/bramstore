import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/ui/views/bottom_nav_view.dart';
import 'package:bramstore/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class CheckoutViewModel extends BaseModel {
  List kurir = [];
  List layanan = [];
  String radioItem = '';
  String layanan_data = "";
  var value_kurir;
  var value_layanan;
  int biayaongkir = 0;
  int subtotal = 0;
  int total = 0;
  bool isKonfirmasi = false;
  // Group Value for Radio Button.
  String kode = "";
  void initdata() async {
    setBusy(true);
    getListKurir();
    setBusy(false);
  }

  void getListKurir() async {
    final data = await apiService.getKurir();
    kurir = data['data'];
    print(data);
    notifyListeners();
  }

  void getHitungTotal() async {
    setBusy(true);

    List produk = jsonDecode(await storageService.getString(K_MY_CART) ?? "[]");
    List idproduk = [];
    List list_qty = [];
    print(produk);
    print(produk);
    for (var i = 0; i < produk.length; i++) {
      idproduk.add(produk[i]['id']);
      list_qty.add(produk[i]['qty']);
    }

    print(idproduk.join(","));
    print(list_qty.join(","));
    print(value_kurir);
    print(layanan_data);

    final data = await apiService.getHitungTotal(
        idproduk.join(","), list_qty.join(","), value_kurir, layanan_data);
    print(data);
    if (data['status'] == "success") {
      isKonfirmasi = true;
      biayaongkir = data['data']['biaya_ongkir'];
      subtotal = data['data']['subtotal'];
      total = data['data']['total'];
    }

    setBusy(false);
  }

  void getLayananKurir(String kurir) async {
    print("lokal layanan $kurir");
    isKonfirmasi = false;
    biayaongkir = 0;
    layanan_data = "";
    subtotal = 0;
    total = 0;
    final data = await apiService.getKurirLayanan(kurir);
    layanan = data['data'];
    print("layanan $layanan");
    notifyListeners();
  }

  void konfirmasiDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi Pesanan"),
        content: Text(
            "Dengan menekan IYA, maka barang kamu akan terkonfirmasi dan segera lakukan pembayaran"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Tidak"),
          ),
          TextButton(
            onPressed: () {
              pesanBarang(context);
              Navigator.pop(context);
            },
            child: Text("IYA"),
          )
        ],
      ),
    );
  }

  void pesanBarang(BuildContext context) async {
    setBusy(true);

    List produk = jsonDecode(await storageService.getString(K_MY_CART) ?? "[]");
    List idproduk = [];
    List list_qty = [];
    print(produk);
    print(produk);
    for (var i = 0; i < produk.length; i++) {
      idproduk.add(produk[i]['id']);
      list_qty.add(produk[i]['qty']);
    }

    print(idproduk.join(","));
    print(list_qty.join(","));
    print(value_kurir);
    print(layanan_data);

    final data = await apiService.konfirmasiPesanan(
        idproduk.join(","), list_qty.join(","), value_kurir, layanan_data);
    print(data);
    if (data['status'] == "success") {
      isKonfirmasi = false;
      await storageService.setString(K_MY_CART, "[]");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pesanan berhasil terkonfirmasi"),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => BottomNavView()),
            (route) => false);
      });
    }

    setBusy(false);
  }

  void setLayanan(String layanan) async {
    layanan_data = layanan;
    getHitungTotal();
    notifyListeners();
  }
}
