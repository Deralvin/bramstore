import 'package:bramstore/viewmodels/base_model.dart';

class HistoryViewModel extends BaseModel {
  List history_data = [];
  void initdata() async {
    setBusy(true);
    final data = await apiService.getListHistory();
    print(data);
    if (data['status'] == "success") {
      history_data = data['data'];
    } else {
      history_data = [];
    }
    setBusy(false);
  }
}
