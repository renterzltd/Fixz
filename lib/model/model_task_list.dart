class ModelTaskList {
  String message = "";
  List<TaskListData> taskList = [];

  ModelTaskList({this.message = "", this.taskList = const []});

  ModelTaskList.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.taskList = (json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => TaskListData.fromJson(e))
              .toList())!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["message"] = this.message;
    if (this.taskList != null)
      data["data"] = this.taskList.map((e) => e.toJson()).toList();
    return data;
  }
}

class TaskListData {
  int? id;
  String? type;
  int? status;
  String? paymentMethod;
  String? details;
  int? escalate;
  dynamic fixReport;
  dynamic fixCost;
  dynamic addressId;
  int? landloardId;
  dynamic propertyId;
  String? createdAt;
  String? updatedAt;
  String? repairingDate;
  dynamic repairingTime;
  int? hoursEstimate;
  String? description;
  dynamic transactionId;
  dynamic tenantId;
  String? lanloardComment;
  int? isRemoteWork;
  String? location;
  String? time;
  int? rateType;
  int? rate;
  int? ratePerHour;
  String? additionalData1;
  String? additionalData2;
  dynamic additionalData3;
  dynamic categoryId;
  dynamic subcategoryId;
  int? totalQuotation;
  String? isReviewed;
  String? review;

  TaskListData({
    this.id,
    this.type,
    this.status,
    this.paymentMethod,
    this.details,
    this.escalate,
    this.fixReport,
    this.fixCost,
    this.addressId,
    this.landloardId,
    this.propertyId,
    this.createdAt,
    this.updatedAt,
    this.repairingDate,
    this.repairingTime,
    this.hoursEstimate,
    this.description,
    this.transactionId,
    this.tenantId,
    this.lanloardComment,
    this.isRemoteWork,
    this.location,
    this.time,
    this.rateType,
    this.rate,
    this.ratePerHour,
    this.additionalData1,
    this.additionalData2,
    this.additionalData3,
    this.categoryId,
    this.subcategoryId,
    this.totalQuotation,
    this.isReviewed,
    this.review,
  });

  TaskListData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["status"] is int) this.status = json["status"];
    if (json["payment_method"] is String)
      this.paymentMethod = json["payment_method"];
    if (json["details"] is String) this.details = json["details"];
    if (json["escalate"] is int) this.escalate = json["escalate"];
    this.fixReport = json["fix_report"];
    this.fixCost = json["fix_cost"];
    this.addressId = json["address_id"];
    if (json["landloard_id"] is int) this.landloardId = json["landloard_id"];
    this.propertyId = json["property_id"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["repairing_date"] is String)
      this.repairingDate = json["repairing_date"];
    this.repairingTime = json["repairing_time"];
    if (json["hours_estimate"] is int)
      this.hoursEstimate = json["hours_estimate"];
    if (json["description"] is String) this.description = json["description"];
    this.transactionId = json["transaction_id"];
    this.tenantId = json["tenant_id"];
    if (json["lanloard_comment"] is String)
      this.lanloardComment = json["lanloard_comment"];
    if (json["is_remote_work"] is int)
      this.isRemoteWork = json["is_remote_work"];
    if (json["location"] is String) this.location = json["location"];
    if (json["time"] is String) this.time = json["time"];
    if (json["rate_type"] is int) this.rateType = json["rate_type"];
    if (json["rate"] is int) this.rate = json["rate"];
    if (json["rate_per_hour"] is int) this.ratePerHour = json["rate_per_hour"];
    if (json["additional_data1"] is String)
      this.additionalData1 = json["additional_data1"];
    if (json["additional_data2"] is String)
      this.additionalData2 = json["additional_data2"];
    this.additionalData3 = json["additional_data3"];
    this.categoryId = json["category_id"];
    this.subcategoryId = json["subcategory_id"];
    this.isReviewed = json["isReviewed"];
    this.review = json["review"];

    if (json["total_quotation"] is int)
      this.totalQuotation = json["total_quotation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["type"] = this.type;
    data["status"] = this.status;
    data["payment_method"] = this.paymentMethod;
    data["details"] = this.details;
    data["escalate"] = this.escalate;
    data["fix_report"] = this.fixReport;
    data["fix_cost"] = this.fixCost;
    data["address_id"] = this.addressId;
    data["landloard_id"] = this.landloardId;
    data["property_id"] = this.propertyId;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["repairing_date"] = this.repairingDate;
    data["repairing_time"] = this.repairingTime;
    data["hours_estimate"] = this.hoursEstimate;
    data["description"] = this.description;
    data["transaction_id"] = this.transactionId;
    data["tenant_id"] = this.tenantId;
    data["lanloard_comment"] = this.lanloardComment;
    data["is_remote_work"] = this.isRemoteWork;
    data["location"] = this.location;
    data["time"] = this.time;
    data["rate_type"] = this.rateType;
    data["rate"] = this.rate;
    data["rate_per_hour"] = this.ratePerHour;
    data["additional_data1"] = this.additionalData1;
    data["additional_data2"] = this.additionalData2;
    data["additional_data3"] = this.additionalData3;
    data["category_id"] = this.categoryId;
    data["subcategory_id"] = this.subcategoryId;
    data["total_quotation"] = this.totalQuotation;
    data["isReviewed"] = this.isReviewed;
    data["review"] = this.review;
    return data;
  }
}
