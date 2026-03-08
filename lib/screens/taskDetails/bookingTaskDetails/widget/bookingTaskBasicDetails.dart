// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/contractorLocationTracking/OrderTrackingPage.dart';
import 'package:fixz/screens/contractorLocationTracking/contractorTracking.dart';
import 'package:fixz/screens/reviewScreen/reviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingTaskBasicDetails extends StatefulWidget {
  const BookingTaskBasicDetails({Key? key}) : super(key: key);

  @override
  State<BookingTaskBasicDetails> createState() =>
      _BookingTaskBasicDetailsState();
}

class _BookingTaskBasicDetailsState extends State<BookingTaskBasicDetails>
    with ButtonMixin {
  final controller = Get.find<TaskDetailController>();

  _setUserInfoWidget({required String userName}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: prefer_const_constructors
        Image(
          image: AssetImage(
            'assets/images/ic_circle_user.png',
          ),
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
        setWidth(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCommonText(
                'POSTED BY'.tr,
                fontSize: 12,
                color: AppColors.gray.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setCommonText(
                userName,
                fontSize: 12,
                color: AppColors.colorPrimaryDark.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setCommonText(
                'Now'.tr,
                fontSize: 12,
                color: AppColors.black.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 35,
              ),
            ],
          ),
        )
      ],
    );
  }

  _setUserLocationWidget(
      String title, String value, String subValue, IconData icon,
      {Function? onClick}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        setWidth(10),
        Icon(
          icon,
          color: Colors.grey,
        ),
        setWidth(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setCommonText(
                title,
                fontSize: 12,
                color: AppColors.gray.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 1,
              ),
              setHeight(3),
              setCommonText(
                value,
                fontSize: 12,
                color: AppColors.colorPrimaryDark.lightColorHex(),
                fontWeight: FontWeight.w500,
                noOfLine: 2,
              ),
              setHeight(3),
              InkWell(
                onTap: () {},
                child: setCommonText(
                  subValue,
                  fontSize: 12,
                  color: AppColors.black.lightColorHex(),
                  fontWeight: FontWeight.w500,
                  noOfLine: 2,
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 35,
              ),
            ],
          ),
        )
      ],
    );
  }

  _setCommonWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          title,
          fontSize: 15,
          color: Colors.black,
        ),
        setHeight(3),
        setCommonText(
          value,
          fontSize: 13,
          color: Colors.grey,
        ),
      ],
    );
  }

  _setContractorWidget() {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _setCommonWidget('Contractor Name:'.tr,
                  con.taskDetails?.acceptedQuotation?.name ?? ""),
              setHeight(10),
              // _setCommonWidget('Contact Number:'.tr,
              //     con.taskDetails?.acceptedQuotation?.mobileNumber ?? ""),

              setCommonText(
                'Contact Number:'.tr,
                fontSize: 15,
                color: Colors.black,
              ),
              setHeight(3),
              Row(
                children: [
                  Expanded(
                    child: setCommonText(
                      con.taskDetails?.acceptedQuotation?.mobileNumber ?? "",
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (con.taskDetails?.acceptedQuotation?.mobileNumber !=
                          null) {
                        _launchURL(
                            con.taskDetails?.acceptedQuotation?.mobileNumber! ??
                                '');
                      }
                    },
                    child: Icon(
                      Icons.call,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),

              setHeight(10),
              _setCommonWidget('Job Quotation:'.tr,
                  '${SharedManager.shared.getCurrency}${con.taskDetails?.acceptedQuotation?.cost ?? ''}'),
              setHeight(10),
              _setCommonWidget('Number of days to complete job:'.tr,
                  '${con.taskDetails?.acceptedQuotation?.days ?? []} ${"days".tr}'),
            ],
          ),
        );
      },
    );
  }

  _launchURL(String phone) async {
    // final url = 'tel:$phone';
    try {
      // launch("tel://214324234");
      Uri url = Uri.parse('tel:$phone');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        debugPrint("Can't open dial pad.");
      }
    } catch (err) {
      throw 'Could not launch $err';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get user details
    controller.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setCommonText(
              '${con.taskDetails?.details}',
              fontSize: 15,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w500,
              noOfLine: 2,
            ),
            setHeight(15),
            _setUserInfoWidget(userName: con.userName),
            _setUserLocationWidget(
                'LOCATION'.tr,
                con.taskDetails?.location ?? 'Location not found'.tr,
                '',
                Icons.place,
                // 'LOCATION', con.taskDetails.location, 'View map', Icons.place,
                onClick: () {}),
            _setUserLocationWidget(
                'TO BE DONE ON'.tr,
                '${con.taskDetails?.repairingDate}',
                getStringwithNewLine('${con.taskDetails?.time}'),
                Icons.calendar_today,
                onClick: () {}),
            setCommonText(
              'Details'.tr,
              fontSize: 15,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w500,
              noOfLine: 2,
            ),
            setHeight(10),
            setCommonText(
              '${con.taskDetails?.description}',
              fontSize: 13,
              color: AppColors.gray.lightColorHex(),
              fontWeight: FontWeight.w400,
              noOfLine: 3,
            ),
            setHeight(10),
            Divider(color: Colors.grey),
            setHeight(10),
            _setContractorWidget(),
            setHeight(15),
            // createButton(
            //     text: (con.taskDetails?.isReviewed == '0')
            //         ? 'Submit Review'.tr
            //         : 'Job Completed'.tr,
            //     txtColor: Colors.white,
            //     widget: (con.taskDetails?.status == 1)
            //         ? null
            //         : Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Icon(Icons.place, color: Colors.white, size: 20),
            //               setWidth(3),
            //               setCommonText('Track Contractor'.tr,
            //                   color: AppColors.white.lightColorHex())
            //             ],
            //           ),
            //     onBtnClick: () async {
            //       if (con.taskDetails?.status == 0) {
            //         //API call
            //         // Get first location
            //         // If location get we will move to map screen else
            //         // Please wait untill contractor notify you
            //         // NavigationService().setNavigator(ContractorTrackingPage());
            //         //Check in task details is notify or not.
            //         if (con.taskDetails?.isNotify == '1') {
            //           //API CALL FIRST
            //           con.trackContracor();
            //         } else {
            //           AlertClass.shared.setSnackbar(
            //               'You will be able to track the service provider a few hours before the job'
            //                   .tr);
            //         }
            //       } else {
            //         if (con.taskDetails?.isReviewed == '0') {
            //           TENANTREQUEST request = TENANTREQUEST(
            //               con.taskDetails?.id ?? 0,
            //               con.taskDetails?.details,
            //               con.taskDetails?.description ?? '',
            //               con.taskDetails?.time ?? '',
            //               con.taskDetails?.acceptedQuotation?.name ?? '',
            //               con.taskDetails?.status.toString(),
            //               '',
            //               con.taskDetails?.review ?? '',
            //               false,
            //               con.taskDetails?.acceptedQuotation?.contractorId,
            //               con.taskDetails?.acceptedQuotation?.quotationId);

            //           await Navigator.of(context)
            //               .push(MaterialPageRoute(
            //                   builder: (context) =>
            //                       ReviewScreen(request: request)))
            //               .then((value) {
            //             con.getTaskDetails('${con.taskDetails?.id}');
            //           });
            //         }
            //       }
            //     }),
            // setHeight(35),
          ],
        );
      },
    );
  }
}

//assets/images/ic_circle_user.png

class TENANTREQUEST {
  int? id;
  String? title;
  String? description;
  String? time;
  String? tanentName;
  String? status;
  String? landlordComment;
  String? review;
  bool? isReviewed;
  dynamic contractorId;
  dynamic quotationId;
  TENANTREQUEST(
    this.id,
    this.title,
    this.description,
    this.time,
    this.tanentName,
    this.status,
    this.landlordComment,
    this.review,
    this.isReviewed,
    this.contractorId,
    this.quotationId,
  );
}
