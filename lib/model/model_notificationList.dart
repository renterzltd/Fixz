// ignore_for_file: file_names, prefer_collection_literals, unnecessary_this

class ModelNotificationList {
  String? message;
  List<NotificationData>? notificationData;

  ModelNotificationList({this.message, this.notificationData});

  ModelNotificationList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (this.notificationData != null) {
      data['data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? body;
  String? type;
  int? read;
  String? to;
  int? userId;
  String? createdAt;
  String? updatedAt;
  dynamic propertyId;
  List<ContractorData>? contractorData;

  NotificationData(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.read,
      this.to,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.propertyId,
      this.contractorData});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    read = json['read'];
    to = json['to'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    propertyId = json['property_id'];
    if (json['data'] != null) {
      contractorData = <ContractorData>[];
      json['data'].forEach((v) {
        contractorData!.add(ContractorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['read'] = this.read;
    data['to'] = this.to;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['property_id'] = this.propertyId;
    if (this.contractorData != null) {
      data['data'] = this.contractorData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContractorData {
  int? id;
  String? key;
  String? value;
  int? notificationId;
  dynamic createdAt;
  dynamic updatedAt;

  ContractorData(
      {this.id,
      this.key,
      this.value,
      this.notificationId,
      this.createdAt,
      this.updatedAt});

  ContractorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    notificationId = json['notification_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['notification_id'] = this.notificationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
