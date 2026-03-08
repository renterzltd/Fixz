class AutoAssignContractor {
  String? message;
  ContractorData? contractor;

  AutoAssignContractor({this.message, this.contractor});

  AutoAssignContractor.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    contractor =
        json['data'] != null ? ContractorData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (contractor != null) {
      data['data'] = contractor!.toJson();
    }
    return data;
  }
}

class ContractorData {
  String? cost;
  String? days;
  String? status;
  dynamic id;
  String? name;
  dynamic contractorId;
  String? description;
  String? jobDescription;
  String? details;
  String? repairingDate;
  dynamic repairingTime;
  dynamic hoursEstimate;
  String? lanloardComment;
  dynamic appartmentNo;
  dynamic floor;
  dynamic addressLabel;
  String? addressType;
  String? location;
  dynamic avgReviews;
  dynamic totalReviews;
  String? image;

  ContractorData(
      {this.cost,
      this.days,
      this.status,
      this.id,
      this.name,
      this.contractorId,
      this.description,
      this.jobDescription,
      this.details,
      this.repairingDate,
      this.repairingTime,
      this.hoursEstimate,
      this.lanloardComment,
      this.appartmentNo,
      this.floor,
      this.addressLabel,
      this.addressType,
      this.location,
      this.avgReviews,
      this.totalReviews,
      this.image});

  ContractorData.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    days = json['days'];
    status = json['status'];
    id = json['id'];
    name = json['name'];
    contractorId = json['contractor_id'];
    description = json['description'];
    jobDescription = json['job_description'];
    details = json['details'];
    repairingDate = json['repairing_date'];
    repairingTime = json['repairing_time'];
    hoursEstimate = json['hours_estimate'];
    lanloardComment = json['lanloard_comment'];
    appartmentNo = json['appartment_no'];
    floor = json['floor'];
    addressLabel = json['address_label'];
    addressType = json['address_type'];
    location = json['location'];
    avgReviews = json['avg_reviews'];
    totalReviews = json['total_reviews'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cost'] = cost;
    data['days'] = days;
    data['status'] = status;
    data['id'] = id;
    data['name'] = name;
    data['contractor_id'] = contractorId;
    data['description'] = description;
    data['job_description'] = jobDescription;
    data['details'] = details;
    data['repairing_date'] = repairingDate;
    data['repairing_time'] = repairingTime;
    data['hours_estimate'] = hoursEstimate;
    data['lanloard_comment'] = lanloardComment;
    data['appartment_no'] = appartmentNo;
    data['floor'] = floor;
    data['address_label'] = addressLabel;
    data['address_type'] = addressType;
    data['location'] = location;
    data['avg_reviews'] = avgReviews;
    data['total_reviews'] = totalReviews;
    data['image'] = image;
    return data;
  }
}
