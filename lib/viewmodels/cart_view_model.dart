import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/viewmodels/base_model.dart';

class CartViewModel extends BaseModel {
  int page = 1;
  int qty = 1;
  int summary = 0;
  List<dynamic> list_clothes = [];
  void init() async {
    setBusy(true);
    changePage(1);
    list_clothes =
        jsonDecode(await storageService.getString(K_MY_CART) ?? "[]");
    print(list_clothes);
    list_clothes.forEach((element) {
      print(element);
      summary = summary +
          (int.parse(element['harga'].toString()) *
              int.parse(element['qty'].toString()));
    });
    print(summary);
    setBusy(false);
  }

  void changePage(int tags) {
    page = tags;
    notifyListeners();
  }

  void removeCheckout(int index) {
    list_clothes.removeAt(index);
    notifyListeners();
  }
}
