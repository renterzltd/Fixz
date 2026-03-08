// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class UserChat {
  UserChat({
    this.id,
    this.body,
    this.from,
    this.to,
    this.fromType,
    this.toType,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.userId,
    this.image,
    this.imageMsg,
    this.name,
  });

  int? id;
  String? body;
  int? from;
  int? to;
  String? fromType;
  String? toType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userType;
  int? userId;
  String? image;
  String? imageMsg;
  String? name;

  factory UserChat.fromRawJson(String str) =>
      UserChat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["id"] == null ? null : json["id"],
        body: json["body"] == null ? null : json["body"],
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
        fromType: json["from_type"] == null ? null : json["from_type"],
        toType: json["to_type"] == null ? null : json["to_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userType: json["user_type"] == null ? null : json["user_type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        image: json["image"] == null ? null : json["image"],
        imageMsg: json["message_image"] == null ? null : json["message_image"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "body": body == null ? null : body,
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "from_type": fromType == null ? null : fromType,
        "to_type": toType == null ? null : toType,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user_type": userType == null ? null : userType,
        "user_id": userId == null ? null : userId,
        "image": image == null ? null : image,
        "message_image": image == null ? null : imageMsg,
        "name": name == null ? null : name,
      };
}
