// ignore_for_file: prefer_collection_literals

class BaseModel {
  String message = "";
  List<String> data = [];

  BaseModel({this.message = "", this.data = const []});

  BaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
