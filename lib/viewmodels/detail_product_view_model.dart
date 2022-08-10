import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/viewmodels/base_model.dart';

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
