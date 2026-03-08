class ModelCreateTask {
  String message = "";
  TaskData? data;

  ModelCreateTask({this.message = "", this.data});

  ModelCreateTask.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new TaskData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TaskData {
  String? details;
  String? repairingDate;
  String? hoursEstimate;
  String? description;
  String? isRemoteWork;
  String? location;
  String? time;
  String? rateType;
  String? rate;
  String? ratePerHour;
  String? additionalData1;
  String? additionalData2;
  String? additionalData3;
  String? type;
  int? landloardId;
  String? lanloardComment;
  String? updatedAt;
  String? createdAt;
  int? id;

  TaskData(
      {this.details,
      this.repairingDate,
      this.hoursEstimate,
      this.description,
      this.isRemoteWork,
      this.location,
      this.time,
      this.rateType,
      this.rate,
      this.ratePerHour,
      this.additionalData1,
      this.additionalData2,
      this.additionalData3,
      this.type,
      this.landloardId,
      this.lanloardComment,
      this.updatedAt,
      this.createdAt,
      this.id});

  TaskData.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    repairingDate = json['repairing_date'];
    hoursEstimate = json['hours_estimate'];
    description = json['description'];
    isRemoteWork = json['is_remote_work'];
    location = json['location'];
    time = json['time'];
    rateType = json['rate_type'];
    rate = json['rate'];
    ratePerHour = json['rate_per_hour'];
    additionalData1 = json['additional_data1'];
    additionalData2 = json['additional_data2'];
    additionalData3 = json['additional_data3'];
    type = json['type'];
    landloardId = json['landloard_id'];
    lanloardComment = json['lanloard_comment'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['repairing_date'] = this.repairingDate;
    data['hours_estimate'] = this.hoursEstimate;
    data['description'] = this.description;
    data['is_remote_work'] = this.isRemoteWork;
    data['location'] = this.location;
    data['time'] = this.time;
    data['rate_type'] = this.rateType;
    data['rate'] = this.rate;
    data['rate_per_hour'] = this.ratePerHour;
    data['additional_data1'] = this.additionalData1;
    data['additional_data2'] = this.additionalData2;
    data['additional_data3'] = this.additionalData3;
    data['type'] = this.type;
    data['landloard_id'] = this.landloardId;
    data['lanloard_comment'] = this.lanloardComment;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
