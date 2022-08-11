import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/viewmodels/base_model.dart';

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
      biayaongkir = data['data']['biaya_ongkir'];
      subtotal = data['data']['subtotal'];
      total = data['data']['total'];
    }
    setBusy(false);
  }

  void getLayananKurir(String kurir) async {
    print("lokal layanan $kurir");

    final data = await apiService.getKurirLayanan(kurir);
    layanan = data['data'];
    print("layanan $layanan");
    notifyListeners();
  }

  void setLayanan(String layanan) async {
    layanan_data = layanan;
    getHitungTotal();
    notifyListeners();
  }
}
