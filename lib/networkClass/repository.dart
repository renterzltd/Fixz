import 'dart:developer';
import 'dart:io';
import 'package:fixz/hdHelper/exportFile.dart';

import '../hdHelper/sharedManager.dart';

class Repository {
  ApiProvider _apiProvider;
  LocalStorageProvider _localStorageProvider;

  Repository(this._apiProvider, this._localStorageProvider);

  bool isUserLoggedIn() => _localStorageProvider.isUserLoggedIn();

  MyUser getUser() => _localStorageProvider.getUser();

  String getUserType() => _localStorageProvider.getUserType();
  setUserType(String userType) => _localStorageProvider.saveUserType(userType);

  String getUserImage() => _localStorageProvider.getUserImage();

  bool isGuest() => !_localStorageProvider.isUserLoggedIn();

  Future<ApiResponse> login(String mobile) async {
    ApiResponse response = await _apiProvider.login(mobile, '');

    if (response.status == Status.COMPLETED) {
      if (response.data is MyUser) {
        MyUser user = response.data;
        if (user.token != null && user.token!.isNotEmpty) {
          _localStorageProvider.saveAccessToken(user.token!);
          return ApiResponse.completed(user.token);
        }
      }
    }
    return response;
  }

  Future<ApiResponse> verify(String code) async {
    ApiResponse response =
        await _apiProvider.verify(code, _localStorageProvider.getAccessToken());

    if (response.status == Status.COMPLETED) {
      if (response.data is MyUser) {
        MyUser user = response.data;
        _localStorageProvider.saveUser(user);
        _localStorageProvider.saveUserImage(user.image!);
        return ApiResponse.completed(user);
      }
    }
    return response;
  }

  Future<ResSendOTP> resendVerfiyCode() async {
    ResSendOTP response = await _apiProvider
        .resendVerfiyCode(_localStorageProvider.getAccessToken());

    // if (response.status == Status.COMPLETED) {
    //   return ApiResponse.completed(response);
    // }
    return response;
  }

  Future<ApiResponse> signup(
      String email, String number, String name, String token) async {
    ApiResponse response = await _apiProvider.signup(
        email, number, name, _localStorageProvider.getAccessToken(), token);

    if (response.status == Status.COMPLETED) {
      if (response.data is MyUser) {
        MyUser user = response.data;
        if (user.token != null && user.token!.isNotEmpty) {
          _localStorageProvider.saveAccessToken(user.token!);
          return ApiResponse.completed(user.token);
        }
      }
    }
    return response;
  }

  Future<ApiResponse> updateFcmToken(String token) async {
    ApiResponse response = await _apiProvider.updateFcmToken(
        _localStorageProvider.getAccessToken(), token);
    log('Status: ${response.status}');
    if (response.status == Status.COMPLETED) {
      return ApiResponse.completed("");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (SharedManager.shared.isSocialLogin) {
        await SharedManager.shared.googleSignIn.signOut();
        await prefs.setString('isHomeViewerLogin', 'no');
        NavigationService()
            .setNavigator(const HomeViewerDashboard(), isRemoveAll: true);
      }
      _makeLogout();
    }
    return response;
  }

  _makeLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await EasyLoading.show(status: 'Loading...'.tr);
    // ApiProvider _apiProvider = ApiProvider();
    final token = prefs.getString('accessTokenKey')!;
    await ApiProvider().logout(token).then((value) async {
      await EasyLoading.dismiss();
      LocalStorageProvider localStorage = LocalStorageProvider(prefs);
      await localStorage.clearData();
      await localStorage.clearUser();
      await prefs.setString('isHomeViewerLogin', 'no');
      NavigationService()
          .setNavigator(const HomeViewerDashboard(), isRemoveAll: true);
    });
  }

  Future<ApiResponse> uploadImage(File id) async {
    ApiResponse response = await _apiProvider.uploadImage(
        id, _localStorageProvider.getAccessToken());

    if (response.isCompleted())
      _localStorageProvider.saveUserImage(response.data);

    return response;
  }

  Future<ApiResponse> uploadImageToProperty(File image, String id) async {
    ApiResponse response = await _apiProvider.uploadImageToProperty(
        image, id, _localStorageProvider.getAccessToken());
    return response;
  }

  Future<ApiResponse> logout() async {
    ApiResponse response =
        await _apiProvider.logout(_localStorageProvider.getAccessToken());

    if (response.isCompleted()) {
      _localStorageProvider.clearData();
      _localStorageProvider.clearUser();
    }

    return response;
  }

  Future<ApiResponse> sendMessageToUser(
      String id, String message, bool isMsgViewRequest) async {
    return await _apiProvider.sendMessageToUser(
        id, message, _localStorageProvider.getAccessToken(), isMsgViewRequest);
  }

  Future<ApiResponse> sendMessageToUserWithImage(
      String id, String message, bool isMsgViewRequest, File image) async {
    return await _apiProvider.sendMessageToUserWithImage(id, message,
        _localStorageProvider.getAccessToken(), isMsgViewRequest, image);
  }

  Future<ApiResponse> getChat(
      String id, String lastid, bool isViewRequest) async {
    return await _apiProvider.getChat(
        id, lastid, _localStorageProvider.getAccessToken(), isViewRequest);
  }

// Future<ApiResponse>
  addRepairJob(
      String paymentMethod,
      String details,
      String address,
      int timeSlot,
      int timeSlot2,
      int timeSlot3,
      String type,
      String repaingTime,
      String reparingDate,
      String hourEstimate,
      String description,
      String categoryID,
      String subCategoryId,
      int propertyId) async {
    // return await _apiProvider.addRepairJob(
    //     paymentMethod,
    //     details,
    //     address,
    //     timeSlot,
    //     timeSlot2,
    //     timeSlot3,
    //     type,
    //     _localStorageProvider.getAccessToken(),
    //     repaingTime,
    //     reparingDate,
    //     hourEstimate,
    //     description,
    //     categoryID,
    //     subCategoryId,
    //     propertyId: propertyId);
  }
}
