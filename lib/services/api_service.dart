import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/locator.dart';
import 'package:bramstore/model/kategori_model.dart';
import 'package:bramstore/model/login_model.dart';
import 'package:bramstore/services/storage_service.dart';
import 'package:bramstore/viewmodels/base_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String? baseurl;
  String token = "";
  StorageService storageService = locator<StorageService>();
  final client = http.Client();
  ApiService(url) {
    this.baseurl = url;
    storageService.getString(K_ACCESS_TOKEN).then((value) {
      print("ini token access $value");
      this.token = value!;
    });
  }

  Future<String> tokenaccess() async {
    final token = await storageService.getString(K_ACCESS_TOKEN) ?? "";
    return token;
  }

  Future<LoginModel> loginAttempt(String email, String password) async {
    try {
      final uri = Uri.parse("${baseurl}/login");
      final response = await client.post(
        uri,
        body: {"email": email, "password": password},
      );
      return loginModelFromJson(response.body);
    } catch (e) {
      return LoginModel(
          status: "Failed", message: "Erro Occured $e", content: null);
    }
  }

  Future<KategoriModel> getKategori() async {
    try {
      final uri = Uri.parse("${baseurl}/kategori");
      token = await tokenaccess();
      final response =
          await client.post(uri, headers: {'Authorization': "Bearer $token"});
      return kategoriModelFromJson(response.body);
    } catch (e) {
      return KategoriModel(status: "Failed $e", data: []);
    }
  }

  Future<dynamic> getProduct(
      {String idkategori = "", String keyword = "", String sort = ""}) async {
    try {
      final uri = Uri.parse("${baseurl}/produk");
      token = await tokenaccess();
      final response = await client.post(
        uri,
        headers: {'Authorization': "Bearer $token"},
        body: {"id_kategori": idkategori, "keyword": keyword, "sort": sort},
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"status": "Failed", "message": "$e"};
    }
  }

  Future<dynamic> getDetailProduct({String idProduk = ""}) async {
    try {
      final uri = Uri.parse("${baseurl}/produk/detail");
      token = await tokenaccess();
      final response = await client.post(
        uri,
        headers: {'Authorization': "Bearer $token"},
        body: {"id": idProduk},
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"status": "Failed", "message": "$e"};
    }
  }
}
