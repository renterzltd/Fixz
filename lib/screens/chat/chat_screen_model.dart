import 'dart:async';
import 'dart:io';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/notifier_model.dart';

class ChatScreenModel extends NotifierModel {
  List<UserChat> list = [];
  Repository _repository;
  bool hasMore = true;
  Timer? timer;
  MyUser? user;
  String imageURL = "";

  Future<ApiResponse> getChat(int id, bool isViewRequest) async {
    //

    ApiResponse response =
        await _repository.getChat(id.toString(), "", isViewRequest);

    if (response.isCompleted()) {
      if (list.isNotEmpty && (list.first.id != response.data.first.id)) {
        list.clear();
        list.addAll(response.data);
      } else {
        list.addAll(response.data);
      }
    }

    //

    // timer = Timer(Duration(seconds: 3), () => getChat(id, isViewRequest));
    return response;
  }

  Future<ApiResponse> sendMessageToUser(
      int id, String message, bool isMsgViewRequest) async {
    ApiResponse response = await _repository.sendMessageToUser(
        id.toString(), message, isMsgViewRequest);

    return response;
  }

  Future<ApiResponse> sendMessageToUserWithImage(
      int id, String message, bool isMsgViewRequest, File image) async {
    ApiResponse response = await _repository.sendMessageToUserWithImage(
        id.toString(), message, isMsgViewRequest, image);

    return response;
  }

  Future<bool> loadMore(int id, bool isViewRequest) async {
    // if (!busy) {
    debugPrint("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    getChatPage(id, isViewRequest);
    // }
    return true;
  }

  Future<ApiResponse> getChatPage(int id, bool isViewRequest) async {
    String lastid = "";
    if (list.isNotEmpty) lastid = list.last.id.toString();

    ApiResponse response =
        await _repository.getChat(id.toString(), lastid, isViewRequest);

    if (response.isCompleted()) {
      list.addAll(response.data);
      hasMore = (response.data as List<UserChat>).length > 0;
    }

    return response;
  }

  ChatScreenModel(this._repository, {this.user}) {
    user = _repository.getUser();
    imageURL = _repository.getUserImage();
  }
}
