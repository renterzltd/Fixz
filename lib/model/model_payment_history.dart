class ModelPaymentHistory {
  String? message;
  List<PaymentData>? data;

  ModelPaymentHistory({this.message, this.data});

  ModelPaymentHistory.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => PaymentData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["message"] = this.message;
    if (this.data != null)
      data["data"] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}

class PaymentData {
  String? details;
  String? cost;
  String? days;
  String? createdAt;
  String? status;
  String? contractorName;
  int? contractorId;
  List<Images>? images;

  PaymentData(
      {this.details,
      this.cost,
      this.days,
      this.createdAt,
      this.status,
      this.contractorName,
      this.contractorId,
      this.images});

  PaymentData.fromJson(Map<String, dynamic> json) {
    if (json["details"] is String) this.details = json["details"];
    if (json["cost"] is String) this.cost = json["cost"];
    if (json["days"] is String) this.days = json["days"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["status"] is String) this.status = json["status"];
    if (json["contractor_name"] is String)
      this.contractorName = json["contractor_name"];
    if (json["contractor_id"] is int) this.contractorId = json["contractor_id"];
    if (json["images"] is List)
      this.images = json["images"] == null
          ? null
          : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["details"] = this.details;
    data["cost"] = this.cost;
    data["days"] = this.days;
    data["created_at"] = this.createdAt;
    data["status"] = this.status;
    data["contractor_name"] = this.contractorName;
    data["contractor_id"] = this.contractorId;
    if (this.images != null)
      data["images"] = this.images!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Images {
  int? id;
  String? type;
  String? documentName;
  String? documentType;
  dynamic certificateName;
  dynamic certificateDescription;
  dynamic notes;
  int? rank;
  int? fkId;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
      this.type,
      this.documentName,
      this.documentType,
      this.certificateName,
      this.certificateDescription,
      this.notes,
      this.rank,
      this.fkId,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["type"] is String) this.type = json["type"];
    if (json["document_name"] is String)
      this.documentName = json["document_name"];
    if (json["document_type"] is String)
      this.documentType = json["document_type"];
    this.certificateName = json["certificate_name"];
    this.certificateDescription = json["certificate_description"];
    this.notes = json["notes"];
    if (json["rank"] is int) this.rank = json["rank"];
    if (json["fk_id"] is int) this.fkId = json["fk_id"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["type"] = this.type;
    data["document_name"] = this.documentName;
    data["document_type"] = this.documentType;
    data["certificate_name"] = this.certificateName;
    data["certificate_description"] = this.certificateDescription;
    data["notes"] = this.notes;
    data["rank"] = this.rank;
    data["fk_id"] = this.fkId;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
