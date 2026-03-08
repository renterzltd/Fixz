class ModelReviewList {
  String? message;
  List<ReviewData>? reviewList;

  ModelReviewList({this.message, this.reviewList});

  ModelReviewList.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.reviewList = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => ReviewData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["message"] = this.message;
    if (this.reviewList != null)
      data["data"] = this.reviewList!.map((e) => e.toJson()).toList();
    return data;
  }
}

class ReviewData {
  int? id;
  int? tenantId;
  int? contractorId;
  int? reviews;
  String? message;
  String? created;
  int? quotationId;
  int? jobId;
  String? contractorName;
  String? details;
  List<ProfileImage>? profileImage;

  ReviewData(
      {this.id,
      this.tenantId,
      this.contractorId,
      this.reviews,
      this.message,
      this.created,
      this.quotationId,
      this.jobId,
      this.contractorName,
      this.details,
      this.profileImage});

  ReviewData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["tenant_id"] is int) this.tenantId = json["tenant_id"];
    if (json["contractor_id"] is int) this.contractorId = json["contractor_id"];
    if (json["reviews"] is int) this.reviews = json["reviews"];
    if (json["message"] is String) this.message = json["message"];
    if (json["created"] is String) this.created = json["created"];
    if (json["quotation_id"] is int) this.quotationId = json["quotation_id"];
    if (json["job_id"] is int) this.jobId = json["job_id"];
    if (json["contractor_name"] is String)
      this.contractorName = json["contractor_name"];
    if (json["details"] is String) this.details = json["details"];
    if (json["profile_image"] is List)
      this.profileImage = json["profile_image"] == null
          ? null
          : (json["profile_image"] as List)
              .map((e) => ProfileImage.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["tenant_id"] = this.tenantId;
    data["contractor_id"] = this.contractorId;
    data["reviews"] = this.reviews;
    data["message"] = this.message;
    data["created"] = this.created;
    data["quotation_id"] = this.quotationId;
    data["job_id"] = this.jobId;
    data["contractor_name"] = this.contractorName;
    data["details"] = this.details;
    if (this.profileImage != null)
      data["profile_image"] =
          this.profileImage!.map((e) => e.toJson()).toList();
    return data;
  }
}

class ProfileImage {
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

  ProfileImage(
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

  ProfileImage.fromJson(Map<String, dynamic> json) {
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
