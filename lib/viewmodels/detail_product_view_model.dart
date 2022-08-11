import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/ui/views/bottom_nav_view.dart';
import 'package:bramstore/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DetailProductViewModel extends BaseModel {
  List<dynamic> type_size = [];
  List<dynamic> type_color = [];
  int qty = 1;
  String id_size = "";
  String color_desc = "";
  List detail = [];
  void initdata(String idProduk) async {
    setBusy(true);

    type_color = list_color;
    getDetailProduk(idProduk);
    setBusy(false);
  }

  void addToCart(BuildContext context) async {
    final data = {
      "nama": detail[0]['nama_produk'],
      "id": detail[0]['id'],
      "harga": detail[0]['harga'],
      "ukuran": id_size,
      "qty": qty,
      "gambar": detail[0]['gambar']
    };
    final cart = await storageService.getString(K_MY_CART) ?? "[]";
    print(cart);
    List add_data = jsonDecode(cart);
    print(add_data.length);
    add_data.add(data);
    await storageService.setString(K_MY_CART, jsonEncode(add_data));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Data Berhasil masuk cart")));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => BottomNavView()), (route) => false);
    // await storageService.setString(K_MY_CART, cart);
    // if(cart.length==0)

    // storageService.setStringList(K_MY_CART, jsonEncode(data));
    // final collection = await BoxCollection.open(
    //   'db_local', // Name of your database
    //   {'my_cart'}, // Names of your boxes
    //   path:
    //       './', // Path where to store your boxes (Only used in Flutter / Dart IO)// Key to encrypt your boxes (Only used in Flutter / Dart IO)
    // );
    // var box = Hive.box('my_cart');
    // box.add();
  }

  void selectedsize(String id) {
    setBusy(true);
    if (id_size == id) {
      id_size = "";
    } else {
      id_size = id;
    }
    setBusy(false);
  }

  void selectedColor(String name) {
    setBusy(true);
    if (color_desc == name) {
      color_desc = "";
    } else {
      color_desc = name;
    }
    setBusy(false);
  }

  void increaseQty() {
    qty++;
    notifyListeners();
  }

  void decreaseQty() {
    if (qty == 1) {
      qty = 1;
    } else {
      qty--;
    }
    notifyListeners();
  }

  void getDetailProduk(String idProduk) async {
    final data = await apiService.getDetailProduct(idProduk: idProduk);
    detail = data['data'];
    type_size = data['data'][0]['ukuran'];
    print(data);
    notifyListeners();
  }
}
