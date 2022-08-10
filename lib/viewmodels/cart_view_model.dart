import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/viewmodels/base_model.dart';

class CartViewModel extends BaseModel {
  int page = 1;
  int qty = 1;
  List<dynamic> list_clothes = [];
  void init() async {
    setBusy(true);
    changePage(1);
    list_clothes = cart_list_clothes;
    print(list_clothes);
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
