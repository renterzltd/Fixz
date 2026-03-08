// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class MyUser {
  MyUser({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.birthday,
    this.image,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  DateTime? birthday;
  String? image;
  String? token;

  factory MyUser.fromRawJson(String str) => MyUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        image: json["image"] == null ? null : json["image"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "birthday": birthday == null
            ? null
            : "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "image": image == null ? null : image,
        "token": token == null ? null : token,
      };
}
