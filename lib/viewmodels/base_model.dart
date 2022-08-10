import 'package:bramstore/constants/const.dart';
import 'package:bramstore/locator.dart';
import 'package:bramstore/services/api_service.dart';
import 'package:bramstore/services/storage_service.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  StorageService storageService = locator<StorageService>();
  bool _busy = false;
  bool get busy => _busy;
  ApiService apiService = new ApiService(baseurl);
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
