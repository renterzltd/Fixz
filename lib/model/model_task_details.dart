// class ModelTaskDetails {
//   String message;
//   TaskDetailData taskDetailData;

//   ModelTaskDetails({this.message, this.taskDetailData});

//   ModelTaskDetails.fromJson(Map<String, dynamic> json) {
//     if (json["message"] is String) this.message = json["message"];
//     if (json["data"] is Map)
//       this.taskDetailData =
//           json["data"] == dynamic ? dynamic : TaskDetailData.fromJson(json["data"]);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["message"] = this.message;
//     if (this.taskDetailData != dynamic)
//       data["data"] = this.taskDetailData.toJson();
//     return data;
//   }
// }

// class TaskDetailData {
//   int id;
//   String type;
//   int status;
//   String paymentMethod;
//   String details;
//   int escalate;
//   dynamic fixReport;
//   dynamic fixCost;
//   dynamic addressId;
//   int landloardId;
//   dynamic propertyId;
//   String createdAt;
//   String updatedAt;
//   String repairingDate;
//   dynamic repairingTime;
//   int hoursEstimate;
//   String description;
//   dynamic transactionId;
//   dynamic tenantId;
//   String lanloardComment;
//   int isRemoteWork;
//   String location;
//   String time;
//   int rateType;
//   int rate;
//   int ratePerHour;
//   String additionalData1;
//   dynamic additionalData2;
//   dynamic additionalData3;
//   dynamic categoryId;
//   dynamic subcategoryId;
//   List<Quotations> quotationList;
//   List<TaskImages> images;

//   TaskDetailData(
//       {this.id,
//       this.type,
//       this.status,
//       this.paymentMethod,
//       this.details,
//       this.escalate,
//       this.fixReport,
//       this.fixCost,
//       this.addressId,
//       this.landloardId,
//       this.propertyId,
//       this.createdAt,
//       this.updatedAt,
//       this.repairingDate,
//       this.repairingTime,
//       this.hoursEstimate,
//       this.description,
//       this.transactionId,
//       this.tenantId,
//       this.lanloardComment,
//       this.isRemoteWork,
//       this.location,
//       this.time,
//       this.rateType,
//       this.rate,
//       this.ratePerHour,
//       this.additionalData1,
//       this.additionalData2,
//       this.additionalData3,
//       this.categoryId,
//       this.subcategoryId,
//       this.quotationList,
//       this.images});

//   TaskDetailData.fromJson(Map<String, dynamic> json) {
//     if (json["id"] is int) this.id = json["id"];
//     if (json["type"] is String) this.type = json["type"];
//     if (json["status"] is int) this.status = json["status"];
//     if (json["payment_method"] is String)
//       this.paymentMethod = json["payment_method"];
//     if (json["details"] is String) this.details = json["details"];
//     if (json["escalate"] is int) this.escalate = json["escalate"];
//     this.fixReport = json["fix_report"];
//     this.fixCost = json["fix_cost"];
//     this.addressId = json["address_id"];
//     if (json["landloard_id"] is int) this.landloardId = json["landloard_id"];
//     this.propertyId = json["property_id"];
//     if (json["created_at"] is String) this.createdAt = json["created_at"];
//     if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
//     if (json["repairing_date"] is String)
//       this.repairingDate = json["repairing_date"];
//     this.repairingTime = json["repairing_time"];
//     if (json["hours_estimate"] is int)
//       this.hoursEstimate = json["hours_estimate"];
//     if (json["description"] is String) this.description = json["description"];
//     this.transactionId = json["transaction_id"];
//     this.tenantId = json["tenant_id"];
//     if (json["lanloard_comment"] is String)
//       this.lanloardComment = json["lanloard_comment"];
//     if (json["is_remote_work"] is int)
//       this.isRemoteWork = json["is_remote_work"];
//     if (json["location"] is String) this.location = json["location"];
//     if (json["time"] is String) this.time = json["time"];
//     if (json["rate_type"] is int) this.rateType = json["rate_type"];
//     if (json["rate"] is int) this.rate = json["rate"];
//     if (json["rate_per_hour"] is int) this.ratePerHour = json["rate_per_hour"];
//     if (json["additional_data1"] is String)
//       this.additionalData1 = json["additional_data1"];
//     this.additionalData2 = json["additional_data2"];
//     this.additionalData3 = json["additional_data3"];
//     this.categoryId = json["category_id"];
//     this.subcategoryId = json["subcategory_id"];
//     if (json["quotations"] is List)
//       this.quotationList = json["quotations"] ?? [];
//     if (json['quotations'] != dynamic) {
//       quotationList = <Quotations>[];
//       json['quotations'].forEach((v) {
//         quotationList.add(new Quotations.fromJson(v));
//       });
//     }
//     if (json['images'] != dynamic) {
//       images = <TaskImages>[];
//       json['images'].forEach((v) {
//         images.add(new TaskImages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = this.id;
//     data["type"] = this.type;
//     data["status"] = this.status;
//     data["payment_method"] = this.paymentMethod;
//     data["details"] = this.details;
//     data["escalate"] = this.escalate;
//     data["fix_report"] = this.fixReport;
//     data["fix_cost"] = this.fixCost;
//     data["address_id"] = this.addressId;
//     data["landloard_id"] = this.landloardId;
//     data["property_id"] = this.propertyId;
//     data["created_at"] = this.createdAt;
//     data["updated_at"] = this.updatedAt;
//     data["repairing_date"] = this.repairingDate;
//     data["repairing_time"] = this.repairingTime;
//     data["hours_estimate"] = this.hoursEstimate;
//     data["description"] = this.description;
//     data["transaction_id"] = this.transactionId;
//     data["tenant_id"] = this.tenantId;
//     data["lanloard_comment"] = this.lanloardComment;
//     data["is_remote_work"] = this.isRemoteWork;
//     data["location"] = this.location;
//     data["time"] = this.time;
//     data["rate_type"] = this.rateType;
//     data["rate"] = this.rate;
//     data["rate_per_hour"] = this.ratePerHour;
//     data["additional_data1"] = this.additionalData1;
//     data["additional_data2"] = this.additionalData2;
//     data["additional_data3"] = this.additionalData3;
//     data["category_id"] = this.categoryId;
//     data["subcategory_id"] = this.subcategoryId;
//     if (this.quotationList != dynamic) {
//       data['quotations'] = this.quotationList.map((v) => v.toJson()).toList();
//     }
//     if (this.quotationList != dynamic) data["quotations"] = this.quotationList;
//     return data;
//   }
// }

// class Quotations {
//   int id;
//   String cost;
//   String days;
//   int contractorId;
//   int jobId;
//   String status;
//   String createdAt;
//   String updatedAt;
//   String description;
//   String name;
//   String profilePicture;

//   Quotations(
//       {this.id,
//       this.cost,
//       this.days,
//       this.contractorId,
//       this.jobId,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.description,
//       this.name,
//       this.profilePicture});

//   Quotations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cost = json['cost'];
//     days = json['days'];
//     contractorId = json['contractor_id'];
//     jobId = json['job_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     description = json['description'];
//     name = json['name'];
//     profilePicture = json['profile_picture'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['cost'] = this.cost;
//     data['days'] = this.days;
//     data['contractor_id'] = this.contractorId;
//     data['job_id'] = this.jobId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['description'] = this.description;
//     data['name'] = this.name;
//     data['profile_picture'] = this.profilePicture;
//     return data;
//   }
// }

// class TaskImages {
//   String documentName;

//   TaskImages({this.documentName});

//   TaskImages.fromJson(Map<String, dynamic> json) {
//     documentName = json['document_name'];
//   }

// ignore_for_file: unnecessary_this, prefer_collection_literals

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['document_name'] = this.documentName;
//     return data;
//   }
// }
//***********************************NEW ONE*********************************
class ModelTaskDetails {
  String message = "";
  TaskDetailData? taskDetailData;

  ModelTaskDetails({this.message = "", this.taskDetailData});

  ModelTaskDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    taskDetailData = (json['data'] != dynamic
        ? new TaskDetailData.fromJson(json['data'])
        : dynamic) as TaskDetailData?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.taskDetailData != null) {
      data['data'] = this.taskDetailData!.toJson();
    }
    return data;
  }
}

class TaskDetailData {
  int? id;
  String type = "";
  int? status;
  String paymentMethod = "";
  String details = "";
  int? escalate;
  dynamic fixReport;
  dynamic fixCost;
  dynamic addressId;
  int? landloardId;
  dynamic propertyId;
  String createdAt = "";
  String updatedAt = "";
  String repairingDate = "";
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
  dynamic additionalData1;
  dynamic additionalData2;
  dynamic additionalData3;
  dynamic categoryId;
  dynamic subcategoryId;
  List<Quotations> quotations = [];
  List<TaskImages> images = [];
  String? isReviewed;
  String? isReported;
  String? review;
  String? isNotify;
  String? latitude;
  String? longitude;
  AcceptedQuotation? acceptedQuotation;

  TaskDetailData({
    this.id,
    this.type = "",
    this.status,
    this.paymentMethod = "",
    this.details = "",
    this.escalate,
    this.fixReport,
    this.fixCost,
    this.addressId,
    this.landloardId,
    this.propertyId,
    this.createdAt = "",
    this.updatedAt = "",
    this.repairingDate = "",
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
    this.quotations = const [],
    this.images = const [],
    this.isReviewed,
    this.isReported,
    this.review,
    this.isNotify,
    this.latitude,
    this.longitude,
    this.acceptedQuotation,
  });

  TaskDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    details = json['details'];
    escalate = json['escalate'];
    fixReport = json['fix_report'];
    fixCost = json['fix_cost'];
    addressId = json['address_id'];
    landloardId = json['landloard_id'];
    propertyId = json['property_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    repairingDate = json['repairing_date'];
    repairingTime = json['repairing_time'];
    hoursEstimate = json['hours_estimate'];
    description = json['description'];
    transactionId = json['transaction_id'];
    tenantId = json['tenant_id'];
    lanloardComment = json['lanloard_comment'];
    isRemoteWork = json['is_remote_work'];
    location = json['location'];
    time = json['time'];
    rateType = json['rate_type'];
    rate = json['rate'];
    ratePerHour = json['rate_per_hour'];
    additionalData1 = json['additional_data1'];
    additionalData2 = json['additional_data2'];
    additionalData3 = json['additional_data3'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotify = json['isNotify'];
    if (json['quotations'] != dynamic) {
      quotations = <Quotations>[];
      json['quotations'].forEach((v) {
        quotations.add(new Quotations.fromJson(v));
      });
    }
    if (json['images'] != dynamic) {
      images = <TaskImages>[];
      json['images'].forEach((v) {
        images.add(new TaskImages.fromJson(v));
      });
    }
    isReviewed = json['isReviewed'];
    isReported = json['isReported'];
    review = json['review '];
    acceptedQuotation = json['accepted_quotation'] != null
        ? new AcceptedQuotation.fromJson(json['accepted_quotation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['details'] = this.details;
    data['escalate'] = this.escalate;
    data['fix_report'] = this.fixReport;
    data['fix_cost'] = this.fixCost;
    data['address_id'] = this.addressId;
    data['landloard_id'] = this.landloardId;
    data['property_id'] = this.propertyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['repairing_date'] = this.repairingDate;
    data['repairing_time'] = this.repairingTime;
    data['hours_estimate'] = this.hoursEstimate;
    data['description'] = this.description;
    data['transaction_id'] = this.transactionId;
    data['tenant_id'] = this.tenantId;
    data['lanloard_comment'] = this.lanloardComment;
    data['is_remote_work'] = this.isRemoteWork;
    data['location'] = this.location;
    data['time'] = this.time;
    data['rate_type'] = this.rateType;
    data['rate'] = this.rate;
    data['rate_per_hour'] = this.ratePerHour;
    data['additional_data1'] = this.additionalData1;
    data['additional_data2'] = this.additionalData2;
    data['additional_data3'] = this.additionalData3;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['isNotify'] = this.isNotify;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['quotations'] = this.quotations.map((v) => v.toJson()).toList();
    data['images'] = this.images.map((v) => v.toJson()).toList();
    data['isReviewed'] = this.isReviewed;
    data['isReported'] = this.isReported;
    data['review '] = this.review;
    if (this.acceptedQuotation != null) {
      data['accepted_quotation'] = this.acceptedQuotation!.toJson();
    }
    return data;
  }
}

class Quotations {
  int? id;
  String? cost;
  String? days;
  int? contractorId;
  int? jobId;
  int? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? description;
  String? name;
  String? profilePicture;
  String? avgReviews;
  String? totalReviews;

  Quotations({
    this.id,
    this.cost,
    this.days,
    this.type,
    this.contractorId,
    this.jobId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.name,
    this.avgReviews,
    this.profilePicture,
    this.totalReviews,
  });

  Quotations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    type = json['type'];
    days = json['days'];
    contractorId = json['contractor_id'];
    jobId = json['job_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    avgReviews = json['avg_reviews'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['cost'] = this.cost;
    data['days'] = this.days;
    data['type'] = this.type;
    data['contractor_id'] = this.contractorId;
    data['job_id'] = this.jobId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    data['avg_reviews'] = this.avgReviews;
    data['total_reviews'] = this.totalReviews;
    return data;
  }
}

class TaskImages {
  String? documentName;

  TaskImages({this.documentName});

  TaskImages.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['document_name'] = this.documentName;
    return data;
  }
}

class AcceptedQuotation {
  String? description;
  String? cost;
  String? days;
  String? name;
  int? quotationId;
  int? contractorId;
  String? mobileNumber;

  AcceptedQuotation(
      {this.description,
      this.cost,
      this.days,
      this.name,
      this.quotationId,
      this.contractorId,
      this.mobileNumber});

  AcceptedQuotation.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    cost = json['cost'];
    days = json['days'];
    name = json['name'];
    quotationId = json['id'];
    contractorId = json['contractor_id'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['cost'] = this.cost;
    data['days'] = this.days;
    data['name'] = this.name;
    data['id'] = this.quotationId;
    data['contractor_id'] = this.contractorId;
    data['mobile_number'] = this.mobileNumber;
    return data;
  }
}
