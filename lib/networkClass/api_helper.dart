import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, constant_identifier_names, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as gtx;
import 'package:http/http.dart' as http;
import 'api_response.dart';
import 'app_exception.dart';
import 'dart:io';
import 'package:dio/dio.dart';

// const STAGING_URL = "https://renterz.com/api/";

class ApiBaseHelper {
  // final String _baseUrl = SharedManager.shared.STAGING_URL;

  String cookieValue = "";
  Map<String, String> cookies = {};
  Future<dynamic> get_1(String url) async {
    var responseJson;
    try {
      debugPrint("sending get request $url");
      var headers = <String, String>{};

      var uri = Uri.parse(url);
      final response = await http.get(uri);
      debugPrint("GET request response is ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection'.tr);
    } on UnverifiedUserException {
      debugPrint("UnverifiedUserException");
      debugPrint(UnverifiedUserException);
      throw UnverifiedUserException();
    } catch (e) {
      debugPrint("exc $e");
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${e}');
    }
    return responseJson;
  }

  Future<dynamic> get(String subUrl,
      [String? accessToken, queryParameters]) async {
    var responseJson;
    try {
      debugPrint("sending get request ${SharedManager.shared.STAGING_URL} $subUrl}");
      var headers = <String, String>{};
      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }
      debugPrint("GET request sent with token: Bearer $accessToken");
      debugPrint("ghadeer " + subUrl);

      var uri = Uri.parse(SharedManager.shared.STAGING_URL + subUrl);
      if (queryParameters != null)
        uri = uri.replace(queryParameters: queryParameters);
      debugPrint("ghadeer" + uri.toString());

      final response = await http.get(uri, headers: headers);
      debugPrint("GET request response is ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnverifiedUserException {
      debugPrint("UnverifiedUserException");
      debugPrint(UnverifiedUserException);
      throw UnverifiedUserException();
    } catch (e) {
      debugPrint("exc $e");
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${e}');
    }
    return responseJson;
  }

  Future<dynamic> post(String subUrl, body, [accessToken]) async {
    var responseJson;
    try {
      debugPrint("requesting post with token $accessToken");
      var headers = <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
//      headers["Authorization"] = "Bearer $accessToken";
      if (accessToken != null && accessToken.toString().isNotEmpty)
        headers["Authorization"] = "Bearer $accessToken";
      debugPrint("body ${body}");

//      if (cookieValue.isNotEmpty) {
//        debugPrint("cookieValue $cookieValue");
//        headers["cookie"] = cookieValue;
//      }
      log("ghadeer" + SharedManager.shared.STAGING_URL + subUrl);

      final response = await http.post(
          Uri.parse(SharedManager.shared.STAGING_URL + subUrl),
          body: json.encode(body),
          headers: headers);
      debugPrint("response ${response.statusCode}");
      debugPrint("response ${response.body}");

//      if (cookieValue.isEmpty) {
//        updateCookie(response);
//      }

      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint("SocketException");
      throw FetchDataException('No Internet connection');
    } catch (e) {
      debugPrint("exc $e");
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${e}');
    }
    return responseJson;
  }

  Future<dynamic> delete(String subUrl, [accessToken]) async {
    var responseJson;
    try {
      debugPrint("requesting post with token $accessToken");
      var headers = <String, String>{};
//      headers["Content-Type"] = "application/json";
//      headers["Accept"] = "application/json";
//      headers["Authorization"] = "Bearer $accessToken";
      if (accessToken != null && accessToken.toString().isNotEmpty)
        headers["Authorization"] = "Bearer $accessToken";

//      if (cookieValue.isNotEmpty) {
//        debugPrint("cookieValue $cookieValue");
//        headers["cookie"] = cookieValue;
//      }

      final response = await http.delete(
          Uri.parse(SharedManager.shared.STAGING_URL + subUrl),
          headers: headers);
      debugPrint("response ${response.statusCode}");
      debugPrint("response ${response.body}");

//      if (cookieValue.isEmpty) {
//        updateCookie(response);
//      }

      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint("SocketException");
      throw FetchDataException('No Internet connection');
    } catch (e) {
      debugPrint("exc $e");
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${e}');
    }
    return responseJson;
  }

  Future<ApiResponse> uploadFile(
      {required String subUrl,
      required File file,
      String? accessToken,
      body,
      fileName = "userfile"}) async {
    try {
      debugPrint("requesting upload file");
      var headers = <String, String>{};
      headers["Accept"] = "application/json";
      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }

      var uri = Uri.parse(SharedManager.shared.STAGING_URL + subUrl);
      debugPrint('API URL is:$uri');

      // FormData formData = FormData.fromMap({
      //   'document_name':
      //       uploa
      // });
      // uploadImageWithParam(formData, url);

      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(fileName, file.path))
        ..headers.addAll(headers)
        ..fields.addAll(body);
      var response = await request.send();

      debugPrint("upload userfile response status code is ${response.statusCode}");

      final respStr = await response.stream.bytesToString();
      debugPrint("upload userfile response status code is $respStr");

      var responss = Map<String, dynamic>();
      responss = json.decode(respStr);
      if (response.statusCode == 201 || response.statusCode == 200)
        return ApiResponse.completed(responss);
      else
        return ApiResponse.error("Error uploading the image try again");

      // var request = http.MultipartRequest('POST', uri);
      // request.files
      //     .add(await http.MultipartFile.fromPath('document_name', file.path));
      // request.headers.addAll(headers);

      // http.StreamedResponse response = await request.send();

      // if (response.statusCode == 200) {
      //   debugPrint('Image response:=====>${await response.stream.bytesToString()}');
      // } else {
      //   debugPrint('Image response error:=====>${response.reasonPhrase}');
      // }

      // var request = new http.MultipartRequest("POST", uri);
      // request.files.add(await http.MultipartFile.fromPath(fileName, file.path));
      // request.headers.addAll(headers);

      // request.send().then((response) async {
      //   if (response.statusCode == 200) {
      //     debugPrint(
      //         "upload userfile response status code is ${response.statusCode}");

      //     final respStr = await response.stream.bytesToString();
      //     debugPrint("upload userfile response status code is $respStr");

      //     var responss = Map<String, dynamic>();
      //     responss = json.decode(respStr);
      //     if (response.statusCode == 201 || response.statusCode == 200)
      //       return ApiResponse.completed(responss);
      //     else
      //       return ApiResponse.error("Error uploading the image try again");
      //   }
      // });
    } catch (e) {
      debugPrint("upload image exception $e");
      return ApiResponse.error("Error uploading the image try again");
    }
  }

  //Common Method for request api
  //API WITH IMAGE
  Future<bool> uploadImageWithParam(
      FormData formData, String url, String accessToken,
      {bool isLoader = true}) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";
    if (accessToken != null) {
      headers["Authorization"] = "Bearer $accessToken";
    }

    if (isLoader) {
      EasyLoading.show(status: 'loading...'.tr);
    }

    Dio dio = new Dio();
    var response = await dio.post(url,
        data: formData,
        options:
            Options(headers: headers, contentType: Headers.jsonContentType));
    if (isLoader) {
      EasyLoading.dismiss();
    }
    debugPrint("Add Campaign Response :${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Uploaded");
      return true;
      // return true;
    } else {
      debugPrint("Failed");
      return false;
      // return false;
    }
  }

  Future<ApiResponse> updateAppUser(
      {required String subUrl,
      required File profilePictureFile,
      required String accessToken,
      required String birthday,
      required String gender,
      required int locationId}) async {
    try {
      var headers = <String, String>{};
      headers["Content-Type"] = "application/json";

      headers["Authorization"] = "Bearer $accessToken";

      var bodyParams = <String, String>{};

      bodyParams['profile[dateOfBirth]'] = '$birthday';
      bodyParams['profile[gender]'] = '$gender';
      bodyParams['profile[locationId]'] = '$locationId';

      var uri = Uri.parse(SharedManager.shared.STAGING_URL + subUrl);

      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
            "profile[image]", profilePictureFile.path))
        ..headers.addAll(headers)
        ..fields.addAll(bodyParams);
      var response = await request.send();

      debugPrint("upload image response status code is ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200)
        return ApiResponse.completed(response);
      else
        return ApiResponse.error("Error uploading the image try again");
    } catch (e) {
      debugPrint("upload image exception $e");
      return ApiResponse.error("Error uploading the image try again");
    }
  }

  dynamic _returnResponse(http.Response response) {
    debugPrint("resonse status is ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
        return responseJson;
      case 412:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
        return responseJson;
      case 401:
      case 403:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie']!;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookieValue = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
