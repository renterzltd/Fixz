// ignore_for_file: prefer_collection_literals, unnecessary_this

class ModelTrackContractor {
  String? message;
  ContractorData? contractorData;

  ModelTrackContractor({message, data});

  ModelTrackContractor.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    contractorData =
        json['data'] != null ? ContractorData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (data != null) {
      data['data'] = this.contractorData!.toJson();
    }
    return data;
  }
}

class ContractorData {
  String? latitude;
  String? longitude;
  int? id;
  String? address;
  String? address2;
  String? postCode;
  String? town;
  String? city;
  String? name;
  String? description;
  String? tiktokLink;
  String? instaLink;
  String? fbLink;
  String? expertises;
  List<String>? images;
  String? avgReviews;
  String? totalReviews;
  String? profileImage;

  ContractorData({
    this.latitude,
    this.longitude,
    this.id,
    this.address,
    this.address2,
    this.postCode,
    this.town,
    this.city,
    this.name,
    this.description,
    this.tiktokLink,
    this.instaLink,
    this.fbLink,
    this.expertises,
    this.images,
    this.avgReviews,
    this.totalReviews,
    this.profileImage,
  });

  ContractorData.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    address = json['address'];
    address2 = json['address2'];
    postCode = json['post_code'];
    town = json['town'];
    city = json['city'];
    name = json['name'];
    description = json['description'];
    tiktokLink = json['tiktok_link'];
    instaLink = json['insta_link'];
    fbLink = json['fb_link'];
    expertises = json['expertises'];
    images = json['images'].cast<String>();
    avgReviews = json['avg_reviews'];
    totalReviews = json['total_reviews'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['id'] = this.id;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['post_code'] = this.postCode;
    data['town'] = this.town;
    data['city'] = this.city;
    data['name'] = this.name;
    data['description'] = this.description;
    data['tiktok_link'] = this.tiktokLink;
    data['insta_link'] = this.instaLink;
    data['fb_link'] = this.fbLink;
    data['expertises'] = this.expertises;
    data['images'] = this.images;
    data['avg_reviews'] = this.avgReviews;
    data['total_reviews'] = this.totalReviews;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
