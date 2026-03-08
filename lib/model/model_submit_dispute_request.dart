class ModelSubmitDisputeRequest {
  String? message;
  RequestData? requestData;

  ModelSubmitDisputeRequest({this.message, this.requestData});

  ModelSubmitDisputeRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    requestData =
        json['data'] != null ? RequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (requestData != null) {
      data['data'] = requestData!.toJson();
    }
    return data;
  }
}

class RequestData {
  String? jobId;
  String? quotationId;
  String? description;
  dynamic userId;
  String? updatedAt;
  String? createdAt;
  dynamic id;

  RequestData(
      {this.jobId,
      this.quotationId,
      this.description,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  RequestData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    quotationId = json['quotation_id'];
    description = json['description'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['quotation_id'] = quotationId;
    data['description'] = description;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
