// ignore_for_file: prefer_collection_literals, unnecessary_this, unnecessary_new

class ModelUpdateProfile {
  String? message;
  ProfileData? profileData;

  ModelUpdateProfile({this.message, this.profileData});

  ModelUpdateProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profileData =
        json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.profileData != null) {
      data['data'] = this.profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? birthday;
  String? verificationCode;
  String? createdAt;
  String? updatedAt;
  String? fcmToken;
  String? type;
  int? userType;
  String? postalCode;
  String? rememberToken;

  ProfileData(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.birthday,
      this.verificationCode,
      this.createdAt,
      this.updatedAt,
      this.fcmToken,
      this.type,
      this.userType,
      this.postalCode,
      this.rememberToken});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    birthday = json['birthday'];
    verificationCode = json['verification_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fcmToken = json['fcm_token'];
    type = json['type'];
    userType = json['user_type'];
    postalCode = json['postal_code'];
    rememberToken = json['remember_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['birthday'] = this.birthday;
    data['verification_code'] = this.verificationCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fcm_token'] = this.fcmToken;
    data['type'] = this.type;
    data['user_type'] = this.userType;
    data['postal_code'] = this.postalCode;
    data['remember_token'] = this.rememberToken;
    return data;
  }
}
