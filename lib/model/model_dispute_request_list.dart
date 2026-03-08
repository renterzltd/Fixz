class ModelDisputeRequestList {
  String? message;
  List<DisputeRequestData>? disputeList;

  ModelDisputeRequestList({this.message, this.disputeList});

  ModelDisputeRequestList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      disputeList = <DisputeRequestData>[];
      json['data'].forEach((v) {
        disputeList!.add(DisputeRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (disputeList != null) {
      data['data'] = disputeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisputeRequestData {
  int? id;
  int? jobId;
  int? quotationId;
  int? userId;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? contractorName;
  String? jobTitle;
  String? jobDescription;
  List<Images>? images;
  List<Images>? video;

  DisputeRequestData({
    this.id,
    this.jobId,
    this.quotationId,
    this.userId,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.contractorName,
    this.jobTitle,
    this.jobDescription,
    this.images,
    this.video,
  });

  DisputeRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    quotationId = json['quotation_id'];
    userId = json['user_id'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contractorName = json['contractor_name'];
    jobTitle = json['job_title'];
    jobDescription = json['job_description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = <Images>[];
      json['video'].forEach((v) {
        video!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['quotation_id'] = quotationId;
    data['user_id'] = userId;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['contractor_name'] = contractorName;
    data['job_title'] = jobTitle;
    data['job_description'] = jobDescription;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? documentName;

  Images({this.documentName});

  Images.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_name'] = documentName;
    return data;
  }
}
