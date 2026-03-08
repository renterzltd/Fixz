// // ignore_for_file: unnecessary_this, prefer_collection_literals

// class ModelHomeProfile {
//   String? message;
//   ProfileData? profileData;

//   ModelHomeProfile({this.message, this.profileData});

//   ModelHomeProfile.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     profileData =
//         json['data'] != null ? ProfileData.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.profileData != null) {
//       data['data'] = this.profileData!.toJson();
//     }
//     return data;
//   }
// }

// class ProfileData {
//   int? id;
//   String? name;
//   String? email;
//   String? mobileNumber;
//   String? birthday;
//   String? verificationCode;
//   String? createdAt;
//   String? updatedAt;
//   String? fcmToken;
//   String? type;
//   int? userType;
//   String? postalCode;
//   String? rememberToken;
//   List<ProfileImage>? profileImage;

//   ProfileData(
//       {this.id,
//       this.name,
//       this.email,
//       this.mobileNumber,
//       this.birthday,
//       this.verificationCode,
//       this.createdAt,
//       this.updatedAt,
//       this.fcmToken,
//       this.type,
//       this.userType,
//       this.postalCode,
//       this.rememberToken,
//       this.profileImage});

//   ProfileData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     mobileNumber = json['mobile_number'];
//     birthday = json['birthday'];
//     verificationCode = json['verification_code'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     fcmToken = json['fcm_token'];
//     type = json['type'];
//     userType = json['user_type'];
//     postalCode = json['postal_code'];
//     rememberToken = json['remember_token'];
//     if (json['profile_image'] != null) {
//       profileImage = <ProfileImage>[];
//       json['profile_image'].forEach((v) {
//         profileImage!.add(ProfileImage.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['mobile_number'] = this.mobileNumber;
//     data['birthday'] = this.birthday;
//     data['verification_code'] = this.verificationCode;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['fcm_token'] = this.fcmToken;
//     data['type'] = this.type;
//     data['user_type'] = this.userType;
//     data['postal_code'] = this.postalCode;
//     data['remember_token'] = this.rememberToken;
//     if (this.profileImage != null) {
//       data['profile_image'] =
//           this.profileImage!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ProfileImage {
//   int? id;
//   String? type;
//   String? documentName;
//   String? documentType;
//   dynamic certificateName;
//   dynamic certificateDescription;
//   dynamic notes;
//   int? rank;
//   int? fkId;
//   String? createdAt;
//   String? updatedAt;

//   ProfileImage(
//       {this.id,
//       this.type,
//       this.documentName,
//       this.documentType,
//       this.certificateName,
//       this.certificateDescription,
//       this.notes,
//       this.rank,
//       this.fkId,
//       this.createdAt,
//       this.updatedAt});

//   ProfileImage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     documentName = json['document_name'];
//     documentType = json['document_type'];
//     certificateName = json['certificate_name'];
//     certificateDescription = json['certificate_description'];
//     notes = json['notes'];
//     rank = json['rank'];
//     fkId = json['fk_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['document_name'] = this.documentName;
//     data['document_type'] = this.documentType;
//     data['certificate_name'] = this.certificateName;
//     data['certificate_description'] = this.certificateDescription;
//     data['notes'] = this.notes;
//     data['rank'] = this.rank;
//     data['fk_id'] = this.fkId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class ModelHomeProfile {
  String? message;
  ProfileData? data;

  ModelHomeProfile({this.message, this.data});

  ModelHomeProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  dynamic rememberToken;
  int? loginType;
  dynamic socialId;
  String? profileImage;

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
      this.rememberToken,
      this.loginType,
      this.socialId,
      this.profileImage});

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
    loginType = json['login_type'];
    socialId = json['social_id'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['login_type'] = this.loginType;
    data['social_id'] = this.socialId;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
