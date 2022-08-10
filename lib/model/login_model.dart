// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.content,
  });

  String? status;
  String? message;
  Content? content;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "content": content == null ? null : content!.toJson(),
      };
}

class Content {
  Content({
    this.data,
    this.accessToken,
    this.tokenType,
  });

  Data? data;
  String? accessToken;
  String? tokenType;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "access_token": accessToken == null ? null : accessToken,
        "token_type": tokenType == null ? null : tokenType,
      };
}

class Data {
  Data({
    this.id,
    this.phone,
    this.name,
    this.email,
    this.city,
    this.address,
    this.birthdate,
    this.gender,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? phone;
  String? name;
  String? email;
  int? city;
  String? address;
  DateTime? birthdate;
  String? gender;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        phone: json["phone"] == null ? null : json["phone"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        gender: json["gender"] == null ? null : json["gender"],
        picture: json["picture"] == null ? null : json["picture"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone": phone == null ? null : phone,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "birthdate": birthdate == null
            ? null
            : "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "gender": gender == null ? null : gender,
        "picture": picture == null ? null : picture,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
