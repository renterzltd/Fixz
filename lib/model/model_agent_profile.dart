// ignore_for_file: prefer_collection_literals

class ModelAgentProfile {
  String? message;
  AgentProfileData? agentProfile;

  ModelAgentProfile({this.message, this.agentProfile});

  ModelAgentProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    agentProfile =
        json['data'] != null ? AgentProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (agentProfile != null) {
      data['data'] = agentProfile!.toJson();
    }
    return data;
  }
}

class AgentProfileData {
  dynamic id;
  String? subType;
  String? name;
  String? profilePicture;
  dynamic totalJobs;
  String? avgReviews;
  String? totalReviews;
  String? fbLink;
  String? instaLink;
  String? tiktokLink;
  String? companyLink;
  dynamic poorCount;
  dynamic averageCount;
  dynamic goodCount;
  dynamic verygoodCount;
  dynamic exellentCount;
  List<ReviewList>? reviewList;

  AgentProfileData(
      {this.id,
      this.subType,
      this.name,
      this.profilePicture,
      this.totalJobs,
      this.avgReviews,
      this.totalReviews,
      this.poorCount,
      this.averageCount,
      this.goodCount,
      this.fbLink,
      this.instaLink,
      this.tiktokLink,
      this.companyLink,
      this.verygoodCount,
      this.exellentCount,
      this.reviewList});

  AgentProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subType = json['sub_type'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    totalJobs = json['total_jobs'];
    avgReviews = json['avg_reviews'];
    totalReviews = json['total_reviews'];
    poorCount = json['poor_count'];
    averageCount = json['average_count'];
    goodCount = json['good_count'];
    verygoodCount = json['verygood_count'];
    exellentCount = json['exellent_count'];
    fbLink = json['fb_link'];
    instaLink = json['insta_link'];
    tiktokLink = json['tiktok_link'];
    companyLink = json['company_link'];
    if (json['review_list'] != null) {
      reviewList = <ReviewList>[];
      json['review_list'].forEach((v) {
        reviewList!.add(ReviewList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['sub_type'] = subType;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    data['total_jobs'] = totalJobs;
    data['avg_reviews'] = avgReviews;
    data['total_reviews'] = totalReviews;
    data['poor_count'] = poorCount;
    data['average_count'] = averageCount;
    data['good_count'] = goodCount;
    data['verygood_count'] = verygoodCount;
    data['exellent_count'] = exellentCount;
    data['fb_link'] = fbLink;
    data['insta_link'] = instaLink;
    data['tiktok_link'] = tiktokLink;
    data['company_link'] = companyLink;
    if (reviewList != null) {
      data['review_list'] = reviewList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewList {
  dynamic reviews;
  String? message;
  dynamic tenantId;
  String? name;
  String? created;

  ReviewList(
      {this.reviews, this.message, this.tenantId, this.name, this.created});

  ReviewList.fromJson(Map<String, dynamic> json) {
    reviews = json['reviews'];
    message = json['message'];
    tenantId = json['tenant_id'];
    name = json['name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['reviews'] = reviews;
    data['message'] = message;
    data['tenant_id'] = tenantId;
    data['name'] = name;
    data['created'] = created;
    return data;
  }
}
