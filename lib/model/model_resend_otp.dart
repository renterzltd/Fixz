// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ResSendOTP {
  String message = "";
  OTPData? data;

  ResSendOTP({this.message = "", this.data});

  ResSendOTP.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new OTPData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OTPData {
  int? id;
  String name = "";
  String email = "";
  String mobileNumber = "";
  String birthday = "";
  int? verificationCode;
  String createdAt = "";
  String updatedAt = "";
  String fcmToken = "";
  String type = "";

  OTPData(
      {this.id,
      this.name = "",
      this.email = "",
      this.mobileNumber = "",
      this.birthday = "",
      this.verificationCode,
      this.createdAt = "",
      this.updatedAt = "",
      this.fcmToken = "",
      this.type = ""});

  OTPData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
