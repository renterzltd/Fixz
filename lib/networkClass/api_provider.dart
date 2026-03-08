// ignore_for_file: avoid_print, unused_element, prefer_collection_literals, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as di;
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/model_address_list_based_on_postcode.dart';
import 'package:fixz/model/model_auto_assign_contractor.dart';
import 'package:fixz/model/model_dispute_request_list.dart';
import 'package:fixz/model/model_notificationList.dart';
import 'package:fixz/model/model_review_list.dart';
import 'package:fixz/model/model_socialLogin.dart';
import 'package:fixz/model/model_submit_dispute_request.dart';
import 'package:fixz/model/model_track_contractor.dart';
import 'package:fixz/model/model_update_profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../model/model_agent_profile.dart';
import 'api_endpoints.dart';
import 'api_helper.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http_parser/http_parser.dart';

class ApiProvider {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  static bool checkResponse(dynamic value) {
    return (value["message"] != null && value["message"] == "success");
  }

  static ApiResponse getErrorResponse(dynamic value) {
    return ApiResponse.response(false, value["message"]);
  }

  Future<ApiResponse> login(String mobile, String fcmToken) async {
    try {
      debugPrint("will login $mobile");
      var map = Map<String, dynamic>();
      map['mobile_number'] = mobile;
      map['sms_token'] = signature;

      debugPrint("login Mobile Partam:=======> $map");

      final response = await _apiBaseHelper.post(ApiEndpoints.LOGIN_API, map);
      debugPrint("login DOEN $response");

      if (checkResponse(response) && response["data"] != null) {
//        debugPrint(User.fromJson(response).toString());
        debugPrint("Duta is hEre");
        return ApiResponse.completed(MyUser.fromJson(response["data"]));
      }
      return getErrorResponse(response);
    } catch (e) {
      debugPrint('Error:$e');
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> verify(String code, String accessToken) async {
    try {
      debugPrint("will verify $code");
      var map = Map<String, dynamic>();
      map['code'] = code;

      final response = await _apiBaseHelper.post(
          ApiEndpoints.VERIFICATION_API, map, accessToken);
      debugPrint("verify DOEN $response");

      if (checkResponse(response) && response["data"] != null) {
        return ApiResponse.completed(MyUser.fromJson(response["data"]));
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  // Future<ApiResponse> resendOTP(String accessToken) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['sms_token'] = signature;

  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.RESEND_VERIFICATION_API, map, accessToken);
  //     debugPrint("verify DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       return ApiResponse.completed(MyUser.fromJson(response["data"]));
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  Future<ResSendOTP> resendVerfiyCode(String accessToken) async {
    try {
      var map = Map<String, dynamic>();
      // map['sms_token'] = signature;
      map['sms_token'] = signature;
      final response = await _apiBaseHelper.post(
          ApiEndpoints.RESEND_VERIFICATION_API, map, accessToken);
      debugPrint("verify DOEN $response");
      return ResSendOTP.fromJson(response);
    } catch (e) {
      return ResSendOTP();
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  Future<ApiResponse> signup(String email, String number, String name,
      String accessToken, String token,
      {String postalCode = ""}) async {
    try {
      debugPrint("will verify $number");
      var map = Map<String, dynamic>();
      map['mobile_number'] = number;
      map['name'] = name;
      map['email'] = email;
      map['sms_token'] = signature;
      map['birthday'] = "2019-05-05";
      map['fcm_token'] = token;
      map['postal_code'] = postalCode;
      final response = await _apiBaseHelper.post(
          ApiEndpoints.Register_API, map, accessToken);
      debugPrint("verify DOEN $response");

      if (checkResponse(response) && response["data"] != null) {
        return ApiResponse.completed(MyUser.fromJson(response["data"]));
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> updateFcmToken(String accessToken, String token) async {
    try {
      var map = Map<String, dynamic>();
      map['fcm_token'] = token;
      final response = await _apiBaseHelper.post(
          ApiEndpoints.SEND_FCM_TOKEN_API, map, accessToken);
      debugPrint("verify DOEN $response");

      if (checkResponse(response) && response["data"] != null) {
        return ApiResponse.completed("");
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  // Future<ApiResponse> getFilteredProperties(
  //     String id, Map<String, dynamic> filter, String accessToken) async {
  //   try {
  //     debugPrint(
  //         "********************API CALLED FOR PROPERTY*****************${ApiEndpoints.GET_Filtered_PROPERTIES_API}");
  //     //  var map = Map <String, dynamic>();

  //     if (id.isNotEmpty) filter["page"] = id;

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_Filtered_PROPERTIES_API, accessToken, filter);
  //     debugPrint("getProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getProperties(String id, String accessToken) async {
  //   try {
  //     debugPrint("will getProperties ");
  //     var map = Map<String, dynamic>();

  //     if (id.isNotEmpty) map["page"] = id;

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_PROPERTIES_API, accessToken, map);
  //     debugPrint("getProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getTenentedProperties(
  //     String id, String accessToken) async {
  //   try {
  //     debugPrint("will getvisitedProperties ");
  //     var map = Map<String, dynamic>();

  //     if (id.isNotEmpty) map["page"] = id;

  //     //     final response = await _apiBaseHelper.get(
  //     //        ApiEndpoints.GET_VisitedProperties_API, accessToken, map);

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_TENANTED_PROPERTIES, accessToken, map);

  //     debugPrint("getvisitedProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getVisitedProperties(
  //     String id, String accessToken) async {
  //   try {
  //     debugPrint("will getvisitedProperties ");
  //     var map = Map<String, dynamic>();

  //     map["type"] = "request_visit";
  //     map["status"] = "0";
  //     //   if (id.isNotEmpty) map["page"] = id;

  //     //     final response = await _apiBaseHelper.get(
  //     //        ApiEndpoints.GET_VisitedProperties_API, accessToken, map);

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_VisitedProperties_API, accessToken, map);

  //     debugPrint("getvisitedProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item["property"]));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getFavoriteProperties(
  //     String id, String accessToken) async {
  //   try {
  //     debugPrint("will getFavoriteProperties ");
  //     var map = Map<String, dynamic>();

  //     if (id.isNotEmpty) map["page"] = id;

  //     final response =
  //         await _apiBaseHelper.get(ApiEndpoints.FAVORITE_API, accessToken, map);
  //     debugPrint("getFavoriteProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getYourProperties(String id, String accessToken) async {
  //   try {
  //     debugPrint("will getProperties ");
  //     var map = Map<String, dynamic>();

  //     if (id.isNotEmpty) map["page"] = id;

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_USER_PROPERTIES_API, accessToken, map);
  //     debugPrint("getProperties DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getNotifications(String id, String accessToken) async {
  //   try {
  //     debugPrint("will getNotifications ");
  //     var map = Map<String, String>();

  //     if (id.isNotEmpty) {
  //       map["page"] = id;
  //     }

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_USER_NOTIFICATIONS_API, accessToken, map);
  //     debugPrint("getNotifications DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<NotificationItem> list = [];
  //       response["data"].forEach((item) {
  //         list.add(NotificationItem.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> deleteNotification(
  //   String id,
  //   String accessToken,
  // ) async {
  //   try {
  //     var map = Map<String, dynamic>();

  //     final response = await _apiBaseHelper.delete(
  //         ApiEndpoints.GET_USER_NOTIFICATIONS_API + "/" + id, accessToken);
  //     debugPrint("addJob DOEN $response");

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> sendOffer(
  //     String id, String accessToken, String offer_object, String offer) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['property_id'] = id;
  //     map['offer_object'] = offer_object;
  //     map['duration'] = offer;

  //     debugPrint("Parameters ==========>$map");
  //     debugPrint("APIS ==========>${ApiEndpoints.REQUEST_PROPERTY_OFFER_API}");

  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.REQUEST_PROPERTY_OFFER_API, map, accessToken);
  //     debugPrint("addJob DOEN $response");

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> sendOfferLandloard(
  //     String offerId, String accessToken, bool accepted, int startDate) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['status'] = (accepted) ? "accept" : "decline";
  //     map['start_date'] = startDate;
  //     map['_method'] = "PUT";

  //     debugPrint("Parameters:$map");
  //     debugPrint("Access Token:$accessToken");
  //     debugPrint(
  //         "API URL:https://renterz.com/api/${ApiEndpoints.REQUEST_PROPERTY_OFFER_API + "/" + offerId}");

  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.REQUEST_PROPERTY_OFFER_API + "/" + offerId,
  //         map,
  //         accessToken);
  //     debugPrint("addJob DOEN $response");

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> deleteProperty(
  //   int id,
  //   String accessToken,
  // ) async {
  //   try {
  //     var map = Map<String, dynamic>();

  //     final response = await _apiBaseHelper.delete(
  //         ApiEndpoints.GET_USER_PROPERTIES_API + "/" + id.toString(),
  //         accessToken);

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> deleteUserChat(
  //   String id,
  //   String accessToken,
  // ) async {
  //   try {
  //     var map = Map<String, dynamic>();

  //     final response = await _apiBaseHelper.delete(
  //         ApiEndpoints.GET_CHAT_WITH_USER_API + "/" + id, accessToken);
  //     debugPrint("addJob DOEN $response");

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> getChatUsers(String id, String accessToken) async {
  //   try {
  //     debugPrint("will getChatUsers ");
  //     var map = Map<String, String>();

  //     if (id.isNotEmpty) {
  //       map["page"] = id;
  //     }

  //     final response = await _apiBaseHelper.get(
  //         ApiEndpoints.GET_CHAT_USERS_API, accessToken, map);
  //     debugPrint("getChatUsers DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<UserChat> list = [];
  //       response["data"].forEach((item) {
  //         list.add(UserChat.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  Future<ApiResponse> getChat(
      String id, String lastid, String accessToken, bool isViewRequest) async {
    try {
      debugPrint("will getChatUsers ");
      var map = Map<String, String>();

      debugPrint("iddddddddddddddddddddddddddddd" + id);
      map["id"] = id;
      map["type"] = isViewRequest ? "LANDLORD" : "AGENT";
      if (lastid != "") map["page"] = lastid;
      final response = await _apiBaseHelper.get(
          ApiEndpoints.GET_CHAT_WITH_USER_API, accessToken, map);
      log("getChatUsers DOEN $response");

      if (checkResponse(response) && response["data"] != null) {
        await EasyLoading.dismiss();
        List<UserChat> list = [];
        response["data"].forEach((item) {
          list.add(UserChat.fromJson(item));
        });
        return ApiResponse.completed(list);
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  // Future<ApiResponse> setPropertyAsFavorite(
  //     String id, String accessToken) async {
  //   try {
  //     debugPrint("will setPropertyAsFavorite ");
  //     var map = Map<String, dynamic>();
  //     map['property_id'] = id;

  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.FAVORITE_API, map, accessToken);
  //     debugPrint("setPropertyAsFavorite DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> addRepairJob(
  //     String paymentMethod,
  //     String details,
  //     String address,
  //     int timeSlot,
  //     int timeSlot2,
  //     int timeSlot3,
  //     String type,
  //     String accessToken,
  //     String repaingTime,
  //     String reparingDate,
  //     String hourEstimate,
  //     String description,
  //     String categoryID,
  //     String subCategoryId,
  //     {int? propertyId}) async {
  //   try {
  //     debugPrint("will addJob ");
  //     var map = Map<String, dynamic>();
  //     map['payment_method'] = paymentMethod;
  //     map['details'] = details;
  //     map['address'] = address;

  //     if (propertyId != null) map['property_id'] = propertyId.toString();

  //     if (type == AppConstant.PROPERTY) map['type'] = "property";
  //     if (type == AppConstant.REQUEST_VISIT) map['type'] = "request_visit";
  //     if (type == AppConstant.REQUEST_REPAIR) map['type'] = "repair";

  //     var slots = [];
  //     var map_appointments = Map<String, dynamic>();
  //     // map_appointments['date'] = timeSlot;

  //     // slots.add(map_appointments);

  //     // if (timeSlot2 != null) {
  //     //   var map_appointments2 = Map<String, dynamic>();
  //     //   map_appointments2['date'] = timeSlot2;
  //     //   slots.add(map_appointments2);
  //     // }
  //     // if (timeSlot3 != null) {
  //     //   var map_appointments3 = Map<String, dynamic>();
  //     //   map_appointments3['date'] = timeSlot3;
  //     //   slots.add(map_appointments3);
  //     // }

  //     map['appointments'] = slots;

  //     //hardik added new data

  //     map['repairing_time'] = repaingTime;
  //     map['repairing_date'] = reparingDate;
  //     map['hours_estimate'] = hourEstimate;
  //     map['description'] = description;
  //     map['category_id'] = categoryID;
  //     map['subcategory_id'] = subCategoryId;

  //     debugPrint("Parameters: $map");

  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.ADD_JOB_API_Repair, map, accessToken);
  //     debugPrint("Repair Request response:===========> $response");
  //     debugPrint(
  //         "Repair Request response ID:===========> ${response['data']['id']}");
  //     // final id = response['data']['id'];
  //     debugPrint("Image data:$repairImage");
  //     if (repairImage != null) {
  //       await uploadRepairImage(
  //           repairImage!, accessToken, '${response['data']['id']}');
  //     }

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> addJob(
  //     String paymentMethod,
  //     String details,
  //     String address,
  //     String timeSlot,
  //     int timeSlot2,
  //     int timeSlot3,
  //     String type,
  //     String accessToken,
  //     {int? propertyId}) async {
  //   try {
  //     debugPrint("will addJob ");
  //     var map = Map<String, dynamic>();
  //     map['payment_method'] = paymentMethod;
  //     map['details'] = details;
  //     map['address'] = address;

  //     if (propertyId != null) map['property_id'] = propertyId.toString();

  //     if (type == AppConstant.PROPERTY) map['type'] = "property";
  //     if (type == AppConstant.REQUEST_VISIT) map['type'] = "request_visit";
  //     if (type == AppConstant.REQUEST_REPAIR) map['type'] = "repair";

  //     var slots = [];
  //     var map_appointments = Map<String, dynamic>();
  //     map_appointments['date'] = timeSlot;

  //     slots.add(map_appointments);

  //     // if (timeSlot2 != null) {
  //     //   var map_appointments2 = Map<String, dynamic>();
  //     //   map_appointments2['date'] = timeSlot2;
  //     //   slots.add(map_appointments2);
  //     // }
  //     // if (timeSlot3 != null) {
  //     //   var map_appointments3 = Map<String, dynamic>();
  //     //   map_appointments3['date'] = timeSlot3;
  //     //   slots.add(map_appointments3);
  //     // }

  //     map['appointments'] = slots;

  //     debugPrint(
  //         'MAP============>$map API END POINT:========${ApiEndpoints.ADD_JOB_API}');

  //     final response =
  //         await _apiBaseHelper.post(ApiEndpoints.ADD_JOB_API, map, accessToken);
  //     debugPrint("addJob DOEN $response");

  //     if (checkResponse(response)) {
  //       return ApiResponse.completed("");
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> setPropertyAsNotFavorite(
  //     String id, String accessToken) async {
  //   try {
  //     debugPrint("will setPropertyAsNotFavorite ");
  //     var map = Map<String, dynamic>();
  //     map['property_id'] = id;

  //     final response = await _apiBaseHelper.delete(
  //         ApiEndpoints.FAVORITE_API + "/$id", accessToken);
  //     debugPrint("setPropertyAsNotFavorite DOEN $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       List<Property> list = [];
  //       response["data"].forEach((item) {
  //         list.add(Property.fromJson(item));
  //       });
  //       return ApiResponse.completed(list);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ModelAddressList> getAddressFromPostCode(String postcode) async {
  //   try {
  //     debugPrint("will getAddressFromPostCode ");
  //     //  var map = Map <String, dynamic>();

  //     var param = "$postcode?api_key=YOUR_IDEAL_POSTCODES_API_KEY";

  //     final response =
  //         await _apiBaseHelper.get_1(ApiEndpoints.ADDRESSES_POSTCODE + param);

  //     debugPrint("getProperties DOEN $response");

  //     if (response["result"] != null) {
  //       return ApiResponse.completed(response["result"]);
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  // Future<ApiResponse> addProperty(
  //     AddProperty property, String accessToken) async {
  //   try {
  //     debugPrint("will addProperty ");
  //     Map<String, dynamic> map = property.toJson();
  //     //   Map<String, dynamic> map=property.toJson();
  //     final response = await _apiBaseHelper.post(
  //         ApiEndpoints.ADD_PROPERTY_API, map, accessToken);

  //     debugPrint("addProperty DONE $response");

  //     if (checkResponse(response) && response["data"] != null) {
  //       return ApiResponse.completed(Property.fromJson(response["data"]));
  //     }
  //     return getErrorResponse(response);
  //   } catch (e) {
  //     return ApiResponse.error("connection error");
  //   }
  // }

  Future<ApiResponse> sendMessageToUser(String id, String message,
      String accessToken, bool isMsgViewRequest) async {
    try {
      var map = Map<String, String>();

      map["to"] = id;
      map["body"] = message;
      map["to_type"] = isMsgViewRequest ? "LANDLORD" : "AGENT";
      log('********************** SEND MESSAGE Response paramete*******************\n$map');
      log('********************** TOKEN*******************\n$accessToken');
      log('********************** SEND MESSAGE URL*******************\n${ApiEndpoints.SEND_MESSAGE_API}');
      final response = await _apiBaseHelper.post(
          ApiEndpoints.SEND_MESSAGE_API, map, accessToken);
      log("SEND_MESSAGE DONE $response");

      if (checkResponse(response) && response["data"] != null) {
        return ApiResponse.completed(Property.fromJson(response["data"]));
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> escalateRequest(String id, String accessToken) async {
    try {
      debugPrint("will logout ");
      var map = Map<String, dynamic>();

      final response = await _apiBaseHelper.post(
          ApiEndpoints.ESCALATE_REQUEST_API + id, map, accessToken);
      debugPrint("logout DOEN $response");

      if (checkResponse(response)) {
        return ApiResponse.completed("");
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> logout(String accessToken) async {
    try {
      debugPrint("will logout ");
      var map = Map<String, dynamic>();

      final response = await _apiBaseHelper.post(
          ApiEndpoints.LOGOUT_REQUEST_API, map, accessToken);
      debugPrint("logout DOEN $response");

      if (checkResponse(response)) {
        return ApiResponse.completed("");
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> sendMessageToUserWithImage(String id, String message,
      String accessToken, bool isMsgViewRequest, File imgFile) async {
    try {
      var map = Map<String, String>();

      map["to"] = id;
      map["body"] = '';
      map["to_type"] = isMsgViewRequest ? "LANDLORD" : "AGENT";
      log('********************** SEND MESSAGE Response paramete*******************\n$map');
      log('********************** TOKEN*******************\n$accessToken');
      log('********************** SEND MESSAGE URL*******************\n${ApiEndpoints.SEND_MESSAGE_API}');

      // map["image_upload"] = "PROFILE_PICTURE";
      final response = await _apiBaseHelper.uploadFile(
        subUrl: ApiEndpoints.SEND_MESSAGE_API,
        file: imgFile,
        body: map,
        fileName: "image_upload",
        accessToken: accessToken,
      );

      // final response = await _apiBaseHelper.post(
      //     ApiEndpoints.SEND_MESSAGE_API, map, accessToken);
      log("SEND_MESSAGE DONE $response");
      var data0 = Map<String, dynamic>();
      data0 = response.data;
      var data1 = Map<String, dynamic>();
      data1 = data0["data"];

      if (checkResponse(response)) {
        return ApiResponse.completed(Property.fromJson(data1));
      }
      return getErrorResponse(response);
    } catch (e) {
      return ApiResponse.error("connection error");
    }
  }

  Future<ApiResponse> uploadImage(File file, String accessToken) async {
    try {
      debugPrint("will uploadImage");
      var map = Map<String, String>();
      map["document_type"] = "PROFILE_PICTURE";
      final response = await _apiBaseHelper.uploadFile(
          subUrl: ApiEndpoints.PROFILE_IMAGE_API,
          file: file,
          body: map,
          fileName: "document_name");
      debugPrint("signupVendor done $response");

      bool iscomplete = response.isCompleted();
      var data0 = Map<String, dynamic>();
      data0 = response.data;
      var data1 = Map<String, dynamic>();
      data1 = data0["data"];
      var data2 = data1["document_name"];

      if (iscomplete && data2 != null) {
        return ApiResponse.completed(data2);
      }

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> uploadRepairImage(
      File file, String accessToken, String id,
      {bool isOther = false}) async {
    debugPrint('========================================');
    try {
      debugPrint("will uploadImage");
      var map = Map<String, String>();
      // map["document_type"] = "PROFILE_PICTURE";
      final response = await _apiBaseHelper.uploadFile(
          subUrl: ApiEndpoints.REPAIR_IMAGE_API + id,
          file: file,
          accessToken: accessToken,
          body: map,
          fileName: "document_name");
      debugPrint("Repair Image Upload Successfully done $response");
      if (!isOther) {
        Fluttertoast.showToast(
            msg: 'Repair Request has been submit successfully!');
      }

      bool iscomplete = response.isCompleted();
      var data0 = Map<String, dynamic>();
      data0 = response.data;
      var data1 = Map<String, dynamic>();
      data1 = data0["data"];
      var data2 = data1["document_name"];

      if (iscomplete && data2 != null) {
        return ApiResponse.completed(data2);
      }

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> uploadImageToProperty(
      File file, String id, String accessToken) async {
    try {
      debugPrint("will uploadImage");
      var map = Map<String, String>();
      // map["document_type"] = "PROFILE_PICTURE";
      final response = await _apiBaseHelper.uploadFile(
          subUrl: ApiEndpoints.Add_IMAGE_To_Property_API + id,
          file: file,
          accessToken: accessToken,
          body: map,
          fileName: "document_name");
      debugPrint("signupVendor done $response");

      if (response.isCompleted() && response.data["data"] != null) {
        return ApiResponse.completed(response.data["data"]["document_name"]);
      }

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  //HD: NEW API
  //MARK: LANDLOARD MANAGE VIEWING

  // Future<ModelTenantRepairList> getTenantRepairRequestList(String api) async {
  //   http.Response response = await _apiRequestWithGet(api);
  //   var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String code = result['message'];
  //     if (code.toLowerCase() == 'success') {
  //       return ModelTenantRepairList.fromJson(json.decode(response.body));
  //     } else {
  //       final object = ModelTenantRepairList();
  //       object.message = result['message'];
  //       object.tenantRepairRequestList = [];
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  // Future<ModelLandlordManageView> getLandndlordManageViewPropertyList() async {
  //   http.Response response =
  //       await _apiRequestWithGet(ApiEndpoints.LANDLOARD_MYJOB_VIEW);
  //   var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String code = result['message'];
  //     if (code.toLowerCase() == 'success') {
  //       return ModelLandlordManageView.fromJson(json.decode(response.body));
  //     } else {
  //       final object = ModelLandlordManageView();
  //       object.message = result['message'];
  //       object.landloardManageViewList = [];
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  // Future<ModelLandlordJobView> getLandloardJobViewDetails(String id) async {
  //   http.Response response =
  //       await _apiRequestWithGet(ApiEndpoints.LANDLOARD_MYJOB_DETAILS + id);
  //   var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String code = result['message'];
  //     if (code.toLowerCase() == 'success') {
  //       return ModelLandlordJobView.fromJson(json.decode(response.body));
  //     } else {
  //       final object = ModelLandlordJobView();
  //       object.message = result['message'];
  //       object.llJovViewdata = LLJobViewData();
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  Future<ModelReviewList> getHomeviewerReviewList() async {
    http.Response response = await _apiRequestWithGet(ApiEndpoints.REVIEW_LIST);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      String code = result['message'];
      if (code.toLowerCase() == 'success') {
        return ModelReviewList.fromJson(json.decode(response.body));
      } else {
        final object = ModelReviewList();
        object.message = result['message'];
        object.reviewList = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelSubmitDisputeRequest> submitDisputeRequest(
      dynamic param, List<File?> images) async {
    http.StreamedResponse? response = await _apiRequestWithStreamResponse(
      ApiEndpoints.SUBMIT_DISPUTE,
      param,
    );
    ModelSubmitDisputeRequest result = ModelSubmitDisputeRequest.fromJson(
      json.decode(
        await response.stream.bytesToString(),
      ),
    );
    debugPrint(
        '=============DISPUTE REAUEST TASK CALLED=======***=========:${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('accessTokenKey') ?? '';

        if (result.message?.toLowerCase() == 'success') {
          for (var image in images) {
            await EasyLoading.show(status: 'Loading...');
            if (image != null) {
              await uploadTaskImages(image, token, '${result.requestData?.id}');
              debugPrint(
                  '=============Image Uploaded Successfully=======***=========:');
            }
            await EasyLoading.dismiss();
          }
          return result;
        } else {
          final object = ModelSubmitDisputeRequest();
          object.message = result.message;
          return object;
        }
      } else {
        throw Exception("Fetch to failed Order Status");
      }
    } on Exception {
      log('error => $response');
      throw Exception("Fetch to failed Order Status");
    } catch (e) {
      log('error => $e');
      throw Exception("Fetch to failed Order Status");
    }
  }

  //Update profile image
  Future<ModelUpdateProfile> updateProfile(dynamic param) async {
    // debugPrint('=============****=======***=========');
    // var result = json.decode(response.body);
    try {
      http.StreamedResponse? response = await _apiRequestWithStreamResponse(
          ApiEndpoints.UPDATE_PROFILE, param);
      ModelUpdateProfile result = ModelUpdateProfile.fromJson(
          json.decode(await response.stream.bytesToString()));

      if (response.statusCode == 200) {
        if (result.message!.toLowerCase() == 'success') {
          return result;
        } else {
          final object = ModelUpdateProfile();
          object.message = result.message;
          object.profileData = null;
          return object;
        }
      } else {
        throw Exception("Fetch to failed Order Status");
      }
    } catch (e) {
      throw Exception("Fetch to failed Order Status ${e.toString()}");
    }
  }
  //MARK: - Login with Social Media -

  Future<ModelSocialLogin> loginWithSocialMedia(dynamic param) async {
    http.StreamedResponse? response = await _apiRequestWithStreamResponse(
        ApiEndpoints.SOCIAL_LOGIN, param,
        isLoader: true);
    ModelSocialLogin result = ModelSocialLogin.fromJson(
        json.decode(await response.stream.bytesToString()));
    // debugPrint('=============****=======***=========');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message!.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelSocialLogin();
        object.message = result.message;
        object.data = null;
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

//MARK: LL Accept Reject job

  // Future<MarkAsDoneDataModel> makeJobDone(dynamic param) async {
  //   http.StreamedResponse? response =
  //       await _apiRequestWithStreamResponse(ApiEndpoints.ADD_JOB_DONE, param);
  //   MarkAsDoneDataModel result = MarkAsDoneDataModel.fromJson(
  //       json.decode(await response!.stream.bytesToString()));
  //   debugPrint('=============****=======***=========');
  //   // var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     if (result.message!.toLowerCase() == 'success') {
  //       return result;
  //     } else {
  //       final object = MarkAsDoneDataModel();
  //       object.message = result.message;
  //       object.data = Data();
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  // Future<BaseModel> updateLandlordRepairRequest(dynamic param) async {
  //   http.StreamedResponse? response = await _apiRequestWithStreamResponse(
  //       ApiEndpoints.UPDATE_REPAIR_REQUEST, param);
  //   BaseModel result =
  //       BaseModel.fromJson(json.decode(await response!.stream.bytesToString()));
  //   debugPrint('=============****=======***=========');
  //   // var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     if (result.message.toLowerCase() == 'success') {
  //       return result;
  //     } else {
  //       final object = BaseModel();
  //       object.message = result.message;
  //       object.data = [];
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

//ADD Ratings
  Future<ModelCreateTask> addHomeviewerTask(
      dynamic param, List<File?> images) async {
    http.StreamedResponse? response =
        await _apiRequestWithStreamResponse(ApiEndpoints.ADD_TASK, param);
    ModelCreateTask result = ModelCreateTask.fromJson(
        json.decode(await response.stream.bytesToString()));
    debugPrint(
        '=============CREATE TASK CALLED=======***=========:${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('accessTokenKey') ?? '';

        if (result.message.toLowerCase() == 'success') {
          for (var image in images) {
            await EasyLoading.show(status: 'Loading...');
            if (image != null) {
              await uploadTaskImages(image, token, result.data!.id.toString());
              debugPrint(
                  '=============Image Uploaded Successfully=======***=========:');
            }
            await EasyLoading.dismiss();
          }
          return result;
        } else {
          final object = ModelCreateTask();
          object.message = result.message;
          object.data = TaskData();
          return object;
        }
      } else {
        throw Exception("Fetch to failed Order Status");
      }
    } on Exception {
      log('error => ${response}');
      throw Exception("Fetch to failed Order Status");
    } catch (e) {
      log('error => $e');
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<void> uploadTaskImages(
    File file,
    String accessToken,
    String id,
  ) async {
    try {
      debugPrint("will uploadImage");
      var map = Map<String, String>();
      final response = await _apiBaseHelper.uploadFile(
          subUrl: ApiEndpoints.REPAIR_IMAGE_API + id,
          file: file,
          accessToken: accessToken,
          body: map,
          fileName: "document_name");
      debugPrint("Repair Image Upload Successfully done $response");
    } catch (e) {
      return AlertClass.shared.shoAlertWindow(e.toString());
    }
  }

  Future<BaseModel> deleteTaks(dynamic param) async {
    http.StreamedResponse? response =
        await _apiRequestWithStreamResponse(ApiEndpoints.TASK_DELETE, param);
    BaseModel result =
        BaseModel.fromJson(json.decode(await response.stream.bytesToString()));
    debugPrint('=============****=======***=========');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message.toLowerCase() == 'success') {
        return result;
      } else {
        final object = BaseModel();
        object.message = result.message;
        object.data = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<BaseModel> updateDisputeRequest(dynamic param) async {
    http.StreamedResponse? response = await _apiRequestWithStreamResponse(
      ApiEndpoints.UPDATE_REPORT_STATUS,
      param,
    );
    BaseModel result =
        BaseModel.fromJson(json.decode(await response.stream.bytesToString()));
    debugPrint('=============****=======***=========');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message.toLowerCase() == 'success') {
        return result;
      } else {
        final object = BaseModel();
        object.message = result.message;
        object.data = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed updateDisputeRequest");
    }
  }

  Future<AutoAssignContractor> autoAssignContractor(String jobId) async {
    try {
      http.StreamedResponse? response = await _apiGetRequestWithStreamResponse(
        ApiEndpoints.AUTO_ASSIGN + jobId,
      );
      AutoAssignContractor result = AutoAssignContractor.fromJson(
          json.decode(await response!.stream.bytesToString()));
      debugPrint('=============****=======***=========${result.message}');
      // var result = json.decode(response.body);
      if (response.statusCode == 200) {
        if (result.message?.toLowerCase() == 'success') {
          return result;
        } else {
          final object = AutoAssignContractor();
          object.message = result.message ?? '';
          return object;
        }
      } else {
        throw Exception("autoAssignContractor:Fetch to failed Order Status");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<BaseModel> addRatings(dynamic param) async {
    http.StreamedResponse? response =
        await _apiRequestWithStreamResponse(ApiEndpoints.GIVE_RATING, param);
    BaseModel result =
        BaseModel.fromJson(json.decode(await response.stream.bytesToString()));
    debugPrint('=============****=======***=========');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message.toLowerCase() == 'success') {
        return result;
      } else {
        final object = BaseModel();
        object.message = result.message;
        object.data = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<BaseModel?> deleteUserRole() async {
    EasyLoading.show(status: 'Loading...');
    final header = await getHeaders();
    BaseModel? result;
    try {
      final url =
          SharedManager.shared.STAGING_URL + ApiEndpoints.DELETE_USER_ROLE;
      log("URL:$url");
      final http.Response response =
          await http.delete(Uri.parse(url), headers: header);
      log("RESULT ==>:${json.decode(response.body)['message']}");
      if (json.decode(response.body)['message'].toString().toLowerCase() ==
          'success') {
        result = BaseModel(data: [], message: 'success');
      }
    } catch (e) {
      log("ERROR: $e");
    }

    return result;
  }

  // Future<ModelLLAcceptRejectView> acceptRejectJob(dynamic param) async {
  //   http.StreamedResponse? response = await _apiRequestWithStreamResponse(
  //       ApiEndpoints.LANDLOARD_ACCPECT_REJECT_JOB, param);
  //   ModelLLAcceptRejectView result = ModelLLAcceptRejectView.fromJson(
  //       json.decode(await response!.stream.bytesToString()));
  //   debugPrint('=============****=======***=========');
  //   // var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     if (result.message.toLowerCase() == 'success') {
  //       return result;
  //     } else {
  //       final object = ModelLLAcceptRejectView();
  //       object.message = result.message;
  //       object.data = AcceptRejectData();
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  // Future<ModelLLAcceptRejectView> changeAlternativeTimeDateJob(
  //     dynamic param) async {
  //   http.StreamedResponse? response = await _apiRequestWithStreamResponse(
  //       ApiEndpoints.LANDLOARD_CHANGE__JOB, param);
  //   ModelLLAcceptRejectView result = ModelLLAcceptRejectView.fromJson(
  //       json.decode(await response!.stream.bytesToString()));
  //   debugPrint('=============****=======***=========');
  //   // var result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     if (result.message.toLowerCase() == 'success') {
  //       return result;
  //     } else {
  //       final object = ModelLLAcceptRejectView();
  //       object.message = result.message;
  //       object.data = AcceptRejectData();
  //       return object;
  //     }
  //   } else {
  //     throw Exception("Fetch to failed Order Status");
  //   }
  // }

  Future<CategoryList> getCategoryList() async {
    http.StreamedResponse? response =
        await _apiGetRequestWithStreamResponse(ApiEndpoints.CATEGORY_LIST);
    CategoryList result = CategoryList.fromJson(
        json.decode(await response!.stream.bytesToString()));
    // debugPrint(
    // '***===***==========***=======***=========***${json.decode(await response!.stream.bytesToString())}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message!.toLowerCase() == 'success') {
        return result;
      } else {
        final object = CategoryList();
        object.message = result.message;
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelHomeProfile> getHomeProfileData() async {
    http.StreamedResponse? response =
        await _apiGetRequestWithStreamResponse(ApiEndpoints.PROFILE_HOME);
    ModelHomeProfile result = ModelHomeProfile.fromJson(
        json.decode(await response!.stream.bytesToString()));
    // debugPrint(
    // '***===***==========***=======***=========***${json.decode(await response!.stream.bytesToString())}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message!.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelHomeProfile();
        object.message = result.message;
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelTaskList> getHomviewerTaskList(String id) async {
    http.StreamedResponse? response =
        await _apiGetRequestWithStreamResponse(ApiEndpoints.TASK_LIST + id);
    ModelTaskList result = ModelTaskList.fromJson(
        json.decode(await response!.stream.bytesToString()));
    debugPrint(
        '***===***==========***=======***=========***${result.toJson()}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelTaskList();
        object.message = result.message;
        object.taskList = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelNotificationList> getNotificationList() async {
    http.StreamedResponse? response = await _apiGetRequestWithStreamResponse(
        ApiEndpoints.GET_USER_NOTIFICATIONS_API);
    ModelNotificationList result = ModelNotificationList.fromJson(
        json.decode(await response!.stream.bytesToString()));
    debugPrint(
        '***===***==========***=======***=========***${result.toJson()}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message!.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelNotificationList();
        object.message = result.message;
        object.notificationData = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelPaymentHistory> getHomviewerPaymentHistory() async {
    http.StreamedResponse? response =
        await _apiGetRequestWithStreamResponse(ApiEndpoints.PAYMENT_HISTORY);
    ModelPaymentHistory result = ModelPaymentHistory.fromJson(
        json.decode(await response!.stream.bytesToString()));
    debugPrint(
        '***===***==========***=======***=========***${result.toJson()}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message!.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelPaymentHistory();
        object.message = result.message;
        object.data = [];
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelTaskDetails> getHomviewerTaskDetails(String id) async {
    http.StreamedResponse? response =
        await _apiGetRequestWithStreamResponse(ApiEndpoints.TASK_DETAILS + id);
    ModelTaskDetails result = ModelTaskDetails.fromJson(
        json.decode(await response!.stream.bytesToString()));
    debugPrint(
        '***===***==========***=======***=========***${result.toJson()}');
    // var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result.message.toLowerCase() == 'success') {
        return result;
      } else {
        final object = ModelTaskDetails();
        object.message = result.message;
        object.taskDetailData = TaskDetailData();
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  // Future<ModelTrackContractor> getContractorLocation(String id) async {
  //   http.StreamedResponse? response = await _apiGetRequestWithStreamResponse(
  //       ApiEndpoints.TRACK_CONTRACTOR + id);
  //   ModelTrackContractor result = ModelTrackContractor.fromJson(
  //       json.decode(await response!.stream.bytesToString()));
  //   // if (response.statusCode == 200) {
  //   if (result.message?.toLowerCase() == 'success') {
  //     return result;
  //   } else {
  //     final object = ModelTrackContractor();
  //     object.message = result.message;
  //     return object;
  //   }
  //   // } else {
  //   //   throw Exception("Fetch to failed Order Status");
  //   // }
  // }
  Future<ModelAddressList> getAddressListBasedOnPostCode(String postcode,
      {bool isLoader = false}) async {
    var param = "$postcode?api_key=YOUR_IDEAL_POSTCODES_API_KEY";

    http.Response response = await _apiRequestWithGet(
        ApiEndpoints.ADDRESSES_POSTCODE + param,
        isPostCodeUrl: true,
        isLoader: isLoader);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      String code = result['message'];
      if (code.toLowerCase() == 'success') {
        return ModelAddressList.fromJson(json.decode(response.body));
      } else {
        final object = ModelAddressList();
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  Future<ModelTrackContractor> getContractorLocation(String id,
      {bool isLoader = false}) async {
    http.Response response = await _apiRequestWithGet(
        ApiEndpoints.TRACK_CONTRACTOR + id,
        isLoader: isLoader);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      String code = result['message'];
      if (code.toLowerCase() == 'success') {
        return ModelTrackContractor.fromJson(json.decode(response.body));
      } else {
        final object = ModelTrackContractor();
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  //GET DISPUTE REQUEST
  Future<ModelDisputeRequestList> getDisputeRequest() async {
    http.Response response =
        await _apiRequestWithGet(ApiEndpoints.DISPUTE_REQUEST_LIST);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      String code = result['message'];
      if (code.toLowerCase() == 'success') {
        return ModelDisputeRequestList.fromJson(json.decode(response.body));
      } else {
        final object = ModelDisputeRequestList();
        return object;
      }
    } else {
      throw Exception("Fetch to failed getDisputeRequest");
    }
  }

  Future<ModelAgentProfile> getContractorProfile(String id,
      {bool isLoader = false}) async {
    http.Response response = await _apiRequestWithGet(
        ApiEndpoints.CONTRACTOR_PROFILE + id,
        isLoader: isLoader);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      String code = result['message'];
      if (code.toLowerCase() == 'success') {
        return ModelAgentProfile.fromJson(json.decode(response.body));
      } else {
        final object = ModelAgentProfile();
        return object;
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  //Multipart Request

  Future<http.StreamedResponse> _apiWithMultipartRequest(
    String url,
    Map<String, String> param,
  ) async {
    log('URL-------------------------------->:${SharedManager.shared.STAGING_URL + url}');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(SharedManager.shared.STAGING_URL + url),
    );
    request.fields.addAll(param);
    request.headers.addAll(await getHeaders());

    http.StreamedResponse? response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
    return response;
  }

  //POST
  Future<http.StreamedResponse> _apiRequestWithStreamResponse(
    String url,
    Map<String, String> jsonMap, {
    bool isLoader = true,
  }) async {
    if (isLoader) {
      EasyLoading.show(status: 'Loading....');
    }
    log('URL-------------------------------->:${SharedManager.shared.STAGING_URL + url}');
    log('Request Parameters:$jsonMap');
    var request = http.Request(
      'POST',
      Uri.parse(SharedManager.shared.STAGING_URL + url),
    );
    request.headers.addAll(await getHeaders());
    request.bodyFields = jsonMap;
    var response = await request.send();

    if (isLoader) {
      EasyLoading.dismiss();
    }
    // debugPrint(await response.stream.bytesToString());

    debugPrint('=============>=======<=========');
    return response;
  }

  //GET
  Future<http.StreamedResponse?> _apiGetRequestWithStreamResponse(
    String url, {
    bool isLoader = true,
  }) async {
    if (isLoader) {
      EasyLoading.show(status: 'Loading....');
    }
    try {
      log('URL-------------------------------->:${SharedManager.shared.STAGING_URL + url}');
      var request = http.Request(
        'GET',
        Uri.parse(SharedManager.shared.STAGING_URL + url),
      );
      request.headers.addAll(await getHeaders());
      var response = await request.send();
      if (isLoader) {
        EasyLoading.dismiss();
      }
      // log(await response.stream.bytesToString());
      // debugPrint('=============>=======<=========:$response');
      return response;
    } catch (e) {
      if (isLoader) {
        EasyLoading.dismiss();
      }
      Exception('Errror message:$e');
      return null;
    }
  }

  //POST
  Future<http.Response> _apiRequest(String url, Map jsonMap,
      {bool isLoader = true}) async {
    if (isLoader) {
      EasyLoading.show(status: 'Loading....');
    }
    log('URL-------------------------------->:${SharedManager.shared.STAGING_URL + url}');
    log('Request Parameters:$jsonMap');
    var body = jsonEncode(jsonMap);
    var response = await http.post(
      Uri.parse(SharedManager.shared.STAGING_URL + url),
      headers: await getHeaders(),
      body: body,
    );
    if (isLoader) {
      EasyLoading.dismiss();
    }
    debugPrint('Response------>${response.body}');
    return response;
  }

//GET
  Future<http.Response> _apiRequestWithGet(String url,
      {bool isLoader = true, bool isPostCodeUrl = false}) async {
    log('URL-------------------------------->:${SharedManager.shared.STAGING_URL + url}');
    if (isLoader) {
      EasyLoading.show(status: 'Loading....');
    }
    var response = await http.get(
      isPostCodeUrl
          ? Uri.parse(url)
          : Uri.parse(SharedManager.shared.STAGING_URL + url),
      headers: await getHeaders(),
    );
    log('Response-------------------------------->:${response.body}');
    if (isLoader) {
      EasyLoading.dismiss();
    }
    return response;
  }

  Future<Map<String, String>> getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessTokenKey') ?? '';

    Map<String, String> headers;

    headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    log('Headers ------------------------------>:$headers');
    return headers;
  }

  Future<ModelSubmitDisputeRequest> submitDispureRequest(
    List<File> files,
    String jobId,
    String quotationId,
    String description, {
    XFile? videoPath,
  }) async {
    di.Dio dio = di.Dio();
    EasyLoading.show(status: 'loading...');
    List<di.MultipartFile> multipartImageList = [];

    for (File asset in files) {
      final file = File(asset.path);
      final byteData = await file.readAsBytes();
      List<int> imageData = byteData.buffer.asUint8List();
      di.MultipartFile multipartFile = di.MultipartFile.fromBytes(
        imageData,
        filename: 'file_name',
        contentType: MediaType("file_name", "png"),
      );
      multipartImageList.add(multipartFile);
    }

    //Video Stuff
    di.MultipartFile? videoFile;
    if (videoPath != null) {
      final videoPathExtension = videoPath.path.split('/').last.split('.').last;
      final byteDataVideo = await videoPath.readAsBytes();
      List<int> videoData = byteDataVideo.buffer.asUint8List();
      // di.MultipartFile videoFile =
      videoFile = di.MultipartFile.fromBytes(
        videoData,
        filename: 'video',
        contentType: MediaType("video", videoPathExtension),
      );
    }

    di.FormData formData = di.FormData.fromMap({
      "images[]": multipartImageList,
      'job_id': jobId,
      'quotation_id': quotationId,
      'description': description,
      'video': videoFile,
    });

    try {
      final url =
          '${SharedManager.shared.STAGING_URL}${ApiEndpoints.SUBMIT_DISPUTE}';
      var response = await dio.post(
        url,
        data: formData,
        options: di.Options(
          headers: await getHeaders(),
        ),
      );
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      EasyLoading.dismiss();
      print("Asset Respoinse is:$response");
      if (response.statusCode == 200) {
        return ModelSubmitDisputeRequest.fromJson(response.data);
      } else {
        return ModelSubmitDisputeRequest();
      }
    } catch (error) {
      throw Exception('Error:${error}');
    }
  }
}
