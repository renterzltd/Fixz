// ignore_for_file: constant_identifier_names, avoid_init_to_null, prefer_if_null_operators, avoid_function_literals_in_foreach_calls, prefer_interpolation_to_compose_strings

import 'package:fixz/hdHelper/exportFile.dart';

class NotificationItem {
  static const String ApplyJob = "Apply Job";
  static const String RequestOffer = "Request Offer";
  static const String ReplyOffer = "Reply Offer";
  static const String OfferResult = "Offer Result";
  static const String RepairIssue = "Repair Issue";
  static const String ConfirmProperty = "Confirm Property";
  static const String VisitDone = "Visit Done";
  static const String NewQuotation = "New Quotation";
  static const String LandloardVisitRequest = "Add Job";
  static const String alternateDate = "Alternate Date";
  static const String declinedJob = "Decline Job";

  NotificationItem(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.read,
      this.to,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.data,
      this.agentId,
      this.propertyId,
      this.agentName});

  int? id;
  String? title;
  String? body;
  String? type;
  int? read;
  String? to;
  int? userId;
  int? propertyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<NotificationData>? data;
  String? userImage = null;
  String? agentName = null;
  String? date = null;
  String? agentDescription = null;
  String? city = null;
  String? postCode = null;
  String? address = null;
  String? agentId;

  factory NotificationItem.fromRawJson(String str) =>
      NotificationItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        type: json["type"] == null ? null : json["type"],
        read: json["read"] == null ? null : json["read"],
        to: json["to"] == null ? null : json["to"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        data: json["data"] == null
            ? null
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
        agentId: json["agentId"] == null ? null : json["agentId"],
        propertyId: json["property_id"] == null ? null : json["property_id"],
        agentName: json["agentName"] == null ? null : json["agentName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "agentName": agentName == null ? null : agentName,
        "agentId": agentId == null ? null : agentId,
        "type": type == null ? null : type,
        "read": read == null ? null : read,
        "to": to == null ? null : to,
        "user_id": userId == null ? null : userId,
        "property_id": propertyId == null ? null : propertyId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  String getImage() {
    return getPhotoValue();
  }

  String getPhotoValue() {
    if (userImage != null) {
      return userImage!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "profile_picture") value = it.value!;
      });
    }
    return value;
  }

  String getDetails() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "job_details") value = it.value!;
      });
    }
    debugPrint("ghadeeeeeeeeeeer" + value);
    return value;
  }

  String getAgentNameValue() {
    if (agentName != null) {
      return agentName!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "name") value = it.value!;
      });
    }
    return value;
  }

  int getAgentId() {
    if (agentId != null) return int.parse(agentId!);
    int value = -1;
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "agent_id") value = int.parse(it.value!);
      });
    }
    return value;
  }

  String getNotificationDateValueAsString() {
    if (date != null && date!.isNotEmpty) {
      return date!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "appointment_date") value = it.value!;
      });
    }
    return value;
  }

  String getAgentDescriptionValue() {
    if (agentDescription != null && agentDescription!.isNotEmpty) {
      return agentDescription!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "agent_description") value = it.value!;
      });
    }
    return value;
  }

  String getCityValue() {
    if (city != null && city!.isNotEmpty) {
      return city!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "city") value = it.value!;
      });
    }
    return value;
  }

  String getPostCodeValue() {
    if (postCode != null && postCode!.isNotEmpty) {
      return postCode!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "post_code") value = it.value!;
      });
    }
    return value;
  }

  String getAddressValue() {
    if (address != null && address!.isNotEmpty) {
      return address!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "job_address") value = it.value!;
      });
    }
    return value;
  }

  String getAddress2Value() {
    if (address != null && address!.isNotEmpty) {
      return address!;
    }
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "address2") value = it.value!;
      });
    }
    debugPrint("Address========>$value");
    return value;
  }

  String getJobIdValue() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "job_id") value = it.value!;
      });
    }
    return value;
  }

  String getQuotationIdValue() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "quotation_id") value = it.value!;
      });
    }
    return value;
  }

  String getduration() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "duration") value = it.value!;
      });
    }
    return value;
  }

  String getOfferObject() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        // debugPrint('IT====================>${it.value!}');
        // debugPrint('IT KEY====================>${it.key}');
        if (it.key == "offer_object") value = it.value!;
      });
    }
    return value;
  }

  String getOfferId() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "offer_id") value = it.value!;
      });
    }
    return value;
  }

  String getPropertyId() {
    String value = "";
    if (data != null) {
      data!.forEach((it) {
        if (it.key == "property_id") value = it.value!;
      });
    }
    return value;
  }
}

class NotificationData {
  NotificationData({
    this.id,
    this.propertyId,
    this.key,
    this.value,
    this.notificationId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? propertyId;
  String? key;
  String? value;
  int? notificationId;
  dynamic createdAt;
  dynamic updatedAt;

  factory NotificationData.fromRawJson(String str) =>
      NotificationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"] == null ? null : json["id"],
        propertyId: json["property_id"] == null ? null : json["property_id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
        notificationId:
            json["notification_id"] == null ? null : json["notification_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "property_id": propertyId == null ? null : propertyId,
        "key": key == null ? null : key,
        "value": value == null ? null : value,
        "notification_id": notificationId == null ? null : notificationId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
