import 'dart:convert';

import 'package:bramstore/constants/const.dart';
import 'package:bramstore/ui/views/bottom_nav_view.dart';
import 'package:bramstore/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  void init(BuildContext context) async {
    final id = await storageService.getInt(K_ID_USER) ?? 0;
    final name = await storageService.getString(K_NAME) ?? "";
    final token = await storageService.getString(K_ACCESS_TOKEN) ?? "";

    print("nama $token");
    if (name != "") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => BottomNavView()), (route) => false);
    }
  }

  void signUpAttempt({
    String email = "",
    String password = "",
    required BuildContext context,
    String nama = "",
    String phone = "",
    String address = "",
  }) async {
    final data = await apiService.registerAttempt(
        email, password, nama, phone, address, "1");
    print(data);
    if (data['status'] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil Register"),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal Register ${data['message']}"),
        ),
      );
    }
  }

  void signInAttempt(
      {String email = "",
      String password = "",
      required BuildContext context}) async {
    setBusy(true);
    final data = await apiService.loginAttempt(email, password);
    print(jsonEncode(data));
    if (data.status == "success") {
      await storageService.setInt(K_ID_USER, data.content!.data!.id ?? 0);
      await storageService.setString(K_PHONE, data.content!.data!.phone ?? "");
      await storageService.setString(K_NAME, data.content!.data!.name ?? "");
      await storageService.setString(K_EMAIL, data.content!.data!.email ?? "");
      await storageService.setInt(K_CITY, data.content!.data!.city ?? 0);
      await storageService.setString(
          K_ADDRESS, data.content!.data!.address ?? "");
      await storageService.setString(
          K_GENDER, data.content!.data!.gender ?? "");
      await storageService.setString(
          K_ACCESS_TOKEN, data.content!.accessToken ?? "");
      // await storageService.setString(
      //     K_BIRTHDAY, data.content!.data!.birthdate!.toIso8601String());

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => BottomNavView()), (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed ${data.message}")));
    }
    setBusy(false);
  }
}
