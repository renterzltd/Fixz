// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/networkClass/api_endpoints.dart';
import 'package:fixz/screens/contractorLocationTracking/OrderTrackingPage.dart';
import 'package:fixz/screens/paymetScreen/tokenScreen.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class TaskDetailController extends GetxController {
  ApiProvider _apiProvider = ApiProvider();
  TaskDetailData? taskDetails;
  List<TaskType> taskTypeList = [];

  var taskStatus = '0';

  var userName = '';
  var userImage = '';

  // CardFieldInputDetails? _card;
  // TokenData? tokenData;
  bool isLoading = true;

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    userName = await getValue(key: DEFAULTKEYS.userName) ?? '';
    userImage = localStorage.getUserImage();
    update();
  }

  fillData() {
    taskTypeList = [
      TaskType(title: 'OPEN'.tr, isSelect: true),
      TaskType(title: 'ASSIGNED'.tr, isSelect: false),
      TaskType(title: 'COMPLETED'.tr, isSelect: false),
      TaskType(title: 'REVIEWED'.tr, isSelect: false),
    ];
  }

  setValue(status) {
    log("STATUS:$status");
    switch (status) {
      case '0':
        _fillArrayStatus(1);
        break;
      case '1':
        _fillArrayStatus(2);
        break;
      case '2':
        _fillArrayStatus(3);
        break;
      case '3':
        _fillArrayStatus(4);
        break;
      default:
    }
  }

  _fillArrayStatus(int count) {
    log("ARRAY COUNT:=>${taskTypeList.length}");
    for (int i = 0; i < count; i++) {
      taskTypeList[i].isSelect = true;
    }
    update();
  }

//API CALL

  trackContracor() async {
    await _apiProvider
        .getContractorLocation('${taskDetails?.quotations.first.contractorId}')
        .then((value) {
      log("Response data:${value.contractorData.toString()}");
      if (value.contractorData != null) {
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .push(MaterialPageRoute(
                builder: (context) => OrderTrackingPage(
                      driverNumber: '',
                      latitude: taskDetails?.latitude,
                      longitude: taskDetails?.longitude,
                      contractorName: 'Contractor'.tr,
                      driverId:
                          taskDetails?.quotations.first.contractorId.toString(),
                      driverLocation: LatLng(
                          double.parse(
                              value.contractorData?.latitude ?? '0.00'),
                          double.parse(
                              value.contractorData?.longitude ?? '0.00')),
                    ),
                fullscreenDialog: true));
      }
    });
  }

  getTaskDetails(String id) async {
    taskDetails = null;
    update();
    await _apiProvider.getHomviewerTaskDetails(id).then((value) async {
      isLoading = false;
      taskDetails = value.taskDetailData ?? TaskDetailData();
      // log('taskDetails.status:${taskDetails.status}');
      // log('taskDetails.isReviewed:${taskDetails.isReviewed}');
      if (taskTypeList.isEmpty) {
        await fillData();
      }
      if (taskDetails?.isReviewed == '1') {
        setValue('3');
      } else if (taskDetails?.isReviewed == '0' && taskDetails?.status == 1) {
        setValue('2');
      } else if (taskDetails?.status! == 0) {
        setValue('1');
      }
      update();
    });
  }

  acceptRejectOffer(bool isAccept, String id, String contractorId,
      {String paymentId = ''}) async {
    // showSnackbar('test', _scaffoldkey, context);
    EasyLoading.show(status: 'Loading...'.tr);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenUser = prefs.getString('accessTokenKey') ?? '';
    String url =
        '${SharedManager.shared.STAGING_URL}landloard/accept-decline-quotation';

    final param = {
      'id': contractorId,
      'status': 'accepted',
      'job_id': id,
    };
    if (paymentId != '') {
      param['transaction_id'] = '$paymentId';
    }
    debugPrint('Final param for accept/reject offer=====>$param');

    await http.post(Uri.parse(url), body: param, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $tokenUser",
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      debugPrint("Response status===>${response.statusCode}");
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        debugPrint('Got Success!!!');
        debugPrint("Response data:${response.body}");
        var responseData = json.decode(response.body);
        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (responseData['message'].toString().toLowerCase() == 'success') {
          Fluttertoast.showToast(msg: 'Offer has been accepted'.tr);

          // NavigationService().setNavigator(TaskScreen());
          Future.delayed(Duration(milliseconds: 300), () {
            currentIndexHomeViewer = 0;
            NavigationService()
                .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
            // Navigator.of(NavigationService.navigatorKey.currentContext!).push(
            //     MaterialPageRoute(builder: (context) => HomeTabbarScreen()));
          });
        } else {
          Fluttertoast.showToast(msg: 'Please try after sometime'.tr);
        }
      } else {
        EasyLoading.dismiss();
        Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
        // throw Exception('Failed to load post');
      }
    });
  }

  void setError(dynamic error) {
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(error.toString())));
    EasyLoading.dismiss();
  }

  makePayment(String token, String cost, String id, String contractorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenUser = prefs.getString('accessTokenKey') ?? '';

    // showInSnackBarWithKey('Payment is processing...', _scaffoldKey, context);
    EasyLoading.show(status: 'Loading...'.tr);

    debugPrint("Strip Token:$token");
    // String url = 'https://renterz.com/api/landloard/payment';
    final param = {
      "payable_amount": cost,
      "payment_token": '',
      "transaction_id": token,
    };

    final url = SharedManager.shared.STAGING_URL + ApiEndpoints.MAKE_PAYMENT;
    log('Parameters=======>$param \n URL: $url');
    final response = await http.post(Uri.parse(url), body: param, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $tokenUser",
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    try {
      if (response.statusCode == 200) {
        debugPrint('Got Success!!!');
        debugPrint("Response data:${response.body}");
        var responseData = json.decode(response.body);
        debugPrint("Response Transaction id:${responseData['data']['id']}");
        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
        EasyLoading.dismiss();
        await acceptRejectOffer(true, id, contractorId,
            paymentId: responseData['data']['id']);
        if (responseData['message'] == 'success') {
          Fluttertoast.showToast(msg: 'Job Assign successfully'.tr);
          Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
        }
      } else {
        throw Exception('Failed to load post');
      }
    } on Exception {
      log("ERROR => 1${response.body}");
      final data = jsonDecode(response.body)['message'];
      AlertClass.shared.setSnackbar(data);
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      log("ERROR => 2$error");
    }
  }

  openCardView(String cost, String taskID, String contractorId) async {
    debugPrint('hellllooooo====>');

    // await Navigator.of(NavigationService.navigatorKey.currentContext!)
    //     .push(MaterialPageRoute(builder: (context) => LegacyTokenCardScreen()))
    //     .then((value) async {
    //   await makePayment(value, cost, taskID, contractorId);
    // });

    // await Navigator.of(NavigationService.navigatorKey.currentContext!)
    //     .push(MaterialPageRoute(
    //   builder: (context) => PaymentScreen(
    //     title: 'Make Payment',
    //     isForQuotation: true,
    //     payentData: (card, expDate, expMonth) async {
    //       debugPrint('=====Card====>$card');
    //       debugPrint('=====expDate====>$expDate');
    //       debugPrint('=====expMonth====>$expMonth');
    //       await _makePayment(
    //           card, expDate, expMonth, cost, taskID, contractorId);
    //     },
    //   ),
    // ));
  }

  // bottomSheetForMakePayment(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (builder) {
  //         return Container(
  //           height: 350.0,
  //           color: Colors.transparent, //could change this to Color(0xFF737373),
  //           //so you don't have to change MaterialApp canvasColor
  //           child: Container(
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: const Radius.circular(10.0),
  //                       topRight: const Radius.circular(10.0))),
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     height: 45,
  //                     alignment: Alignment.center,
  //                     color: AppColors.colorPrimaryDark.lightColorHex(),
  //                     child: setCommonText('Make Payment'.tr,
  //                         color: Colors.white, fontSize: 16),
  //                   ),
  //                   CardField(
  //                     autofocus: true,
  //                     onCardChanged: (card) {
  //                       // setState(() {
  //                       _card = card;
  //                       // });
  //                     },
  //                   ),
  //                   SizedBox(height: 20),
  //                   InkWell(
  //                     onTap: () {
  //                       _handleCreateTokenPress(context);
  //                     },
  //                     child: Container(
  //                       height: 45,
  //                       alignment: Alignment.center,
  //                       color: AppColors.colorPrimaryDark.lightColorHex(),
  //                       child: setCommonText('Make Payment'.tr,
  //                           color: Colors.white, fontSize: 16),
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //         );
  //       });
  // }

  // Future<void> _handleCreateTokenPress(BuildContext context) async {
  //   if (_card == null) {
  //     return;
  //   }

  //   try {
  //     // 1. Gather customer billing information (ex. email)
  //     final address = stripe.Address(
  //       city: '',
  //       country: '',
  //       line1: '',
  //       line2: '',
  //       state: '',
  //       postalCode: '',
  //     ); // mocked data for tests
  //     // 2. Create payment method
  //     final tokenData = await Stripe.instance.createToken(
  //         CreateTokenParams.card(params: CardTokenParams(address: address)));
  //     this.tokenData = tokenData;
  //     debugPrint('Token:$tokenData');
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //     content: Text(
  //     //         'Success: The token was created successfully!\n$tokenData')));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error: $e')));
  //     rethrow;
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //Operations

  openMessageWindow(int index) {
    // offerList.where((element) => element.isOpenComment = false).toList();
    update();
  }

  replyToOffer(int index) {
    update();
  }
}

class TaskType {
  String title;
  bool isSelect;
  TaskType({this.title = "", this.isSelect = false});
}
