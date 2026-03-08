import 'package:fixz/hdHelper/exportFile.dart';

class LocalStorageProvider {
  static const _accessTokenKey = "accessTokenKey";
  static const _profileKey = "profileKey";
  static const _profileImageKey = "profileImageKey";
  static const _userType = "userType";

  SharedPreferences _sharedPreferences;

  LocalStorageProvider(this._sharedPreferences);

  Future<bool> saveAccessToken(String accessToken) async =>
      await _sharedPreferences.setString(_accessTokenKey, accessToken);

  String getAccessToken() =>
      _sharedPreferences.getString(_accessTokenKey) ?? "";

  Future<bool> saveUserType(String userType) async =>
      await _sharedPreferences.setString(_userType, userType);

  String getUserType() => _sharedPreferences.getString(_userType) ?? "";

/*
LandLoard
Tenants
Buyers
 */

  Future<bool> saveUserImage(String img) async =>
      await _sharedPreferences.setString(_profileImageKey, img);

  String getUserImage() => _sharedPreferences.getString(_profileImageKey)!;

  Future<bool> saveUser(MyUser user) async =>
      await _sharedPreferences.setString(_profileKey, user.toRawJson());

  MyUser getUser() =>
      MyUser.fromRawJson(_sharedPreferences.getString(_profileKey)!);
  String getUserStr() => (_sharedPreferences.getString(_profileKey))!;

  bool isUserLoggedIn() => _sharedPreferences.getString(_profileKey) != null;

  Future<bool> clearData() {
    _sharedPreferences.remove(_userType);
    return _sharedPreferences.remove(_accessTokenKey);
  }

  Future<bool> clearUser() {
    return _sharedPreferences.remove(_profileKey);
  }
}
