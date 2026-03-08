// ignore_for_file: file_names, prefer_collection_literals

class ModelSocialLogin {
  String? message;
  SocialData? data;

  ModelSocialLogin({this.message, this.data});

  ModelSocialLogin.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? SocialData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SocialData {
  String? token;

  SocialData({this.token});

  SocialData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    return data;
  }
}
