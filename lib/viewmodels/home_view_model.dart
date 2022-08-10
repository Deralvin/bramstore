import 'dart:convert';

import 'package:bramstore/model/kategori_model.dart' as kategori;
import 'package:bramstore/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  List stringimage = ['assets/banner1.png', 'assets/banner2.png'];
  List<kategori.Datum> list_kategori = [];
  List listproductall = [];
  List? list_banner;
  void initdata() async {
    setBusy(true);
    list_banner = [];
    stringimage.forEach((element) async {
      list_banner!.add(element);
      print(element);
    });
    listKategori();
    listAllProduct();
    setBusy(false);
  }

  void listKategori() async {
    final data = await apiService.getKategori();
    if (data.status == "success") {
      list_kategori = data.data!;
    }
    print(jsonEncode(data));
  }

  void listAllProduct() async {
    final data = await apiService.getProduct();
    print(data);
    listproductall = data['data'];
  }
}
