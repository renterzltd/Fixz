// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/model_track_contractor.dart';
import 'package:fixz/screens/taskDetails/taskDetails/widget/agent_profile.dart';
import 'package:fixz/screens/telrPayment/telrPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'commentListWidget.dart';
import 'contractor_profile.dart';
import 'payment_widget.dart';

class OfferListWidget extends StatefulWidget {
  // final Function(TokenData tokenData)? getTokenData;
  const OfferListWidget({Key? key}) : super(key: key);

  @override
  State<OfferListWidget> createState() => _OfferListWidgetState();
}

class _OfferListWidgetState extends State<OfferListWidget>
    with TextFieldMixin, ButtonMixin {
  //Variables
  final controller = Get.put(TaskDetailController());

  trackContracor(String contractorId) async {
    EasyLoading.show();
    try {
      await ApiProvider().getContractorProfile(contractorId).then((value) {
        EasyLoading.dismiss();
        log("Response data:${value.agentProfile.toString()}");
        if (value.agentProfile != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ContractorProfile(agentProfile: value.agentProfile!),
              fullscreenDialog: true,
            ),
          );
        }
      });
    } on Exception catch (error) {
      EasyLoading.dismiss();
      AlertClass.shared.setSnackbar('please try after sometime: $error');
    } catch (e) {
      EasyLoading.dismiss();
      AlertClass.shared.setSnackbar('please try after sometime: $e');
    }
  }

  _openAgentProfile(ContractorData? contractorData) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return AgentProfile(
            contractorData: contractorData,
          );
        });
  }

  _openBottomSheetForMakePayment(Quotations item) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              // child: PaymentWidget(
              //   getTokenData: (tokenData) {
              //     controller.makePayment(
              //       tokenData.id,
              //       item.cost!,
              //       '${controller.taskDetails?.id}',
              //       '${item.id}',
              //     );
              //   },
              // ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                setCommonText(
                  '${'OFFERS'.tr} (${con.taskDetails?.quotations.length})',
                  fontSize: 12,
                  color: AppColors.black.lightColorHex(),
                  fontWeight: FontWeight.w600,
                  noOfLine: 1,
                ),
                // InkWell(
                //   onTap: () {},
                //   child: setCommonText(
                //     'View All',
                //     fontSize: 12,
                //     color: AppColors.colorPrimaryDark.lightColorHex(),
                //     fontWeight: FontWeight.w600,
                //     noOfLine: 1,
                //   ),
                // ),
              ],
            ),
            setHeight(10),
            MediaQuery.removePadding(
              removeBottom: true,
              context: context,
              child: ListView.builder(
                  itemCount: con.taskDetails?.quotations.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = con.taskDetails!.quotations[index];
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                log('Profile id:${item.contractorId}');
                                trackContracor('${item.contractorId}');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22.5),
                                child: setNetworkImage(
                                    item.profilePicture!, 45, 45),
                              ),
                            ),
                            setWidth(8),
                            Expanded(
                                child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    log('Profile id:${item.contractorId}');
                                    trackContracor('${item.contractorId}');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            setCommonText(
                                              item.name ?? '',
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .lightColorHex(),
                                              fontWeight: FontWeight.w500,
                                              noOfLine: 1,
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                      item.avgReviews ?? '0'),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  ignoreGestures: true,
                                                  itemCount: 5,
                                                  itemSize: 12,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: AppColors
                                                        .colorPrimaryDark
                                                        .lightColorHex(),
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                setCommonText(
                                                  '(${item.totalReviews})',
                                                  fontSize: 12,
                                                  color: AppColors.gray
                                                      .lightColorHex(),
                                                  fontWeight: FontWeight.w500,
                                                  noOfLine: 1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      setWidth(5),
                                      Row(
                                        children: [
                                          setCommonText(
                                            '${SharedManager.shared.getCurrency}${double.parse('${item.cost?.replaceAll(',', '') ?? 0}').toStringAsFixed(2)}',
                                            fontSize: 14,
                                            color:
                                                AppColors.black.lightColorHex(),
                                            fontWeight: FontWeight.w800,
                                            noOfLine: 1,
                                          ),
                                          setWidth(3),
                                          setCommonText(
                                            (item.type == 0)
                                                ? '(${item.days} ${'days'.tr})'
                                                : '(${item.days} ${'Hours'.tr})',
                                            fontSize: 10,
                                            color:
                                                AppColors.gray.lightColorHex(),
                                            fontWeight: FontWeight.w600,
                                            noOfLine: 1,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                setHeight(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    createButton(
                                      height: 28,
                                      width: 80,
                                      fontSize: 12,
                                      borderRadius: BorderRadius.circular(14),
                                      txtColor: AppColors.white.lightColorHex(),
                                      text: 'Message'.tr,
                                      onBtnClick: () {
                                        UserChat itemUser = UserChat();
                                        itemUser.userId = item.contractorId;
                                        itemUser.name = item.name;
                                        debugPrint('id===>${item.id}');
                                        debugPrint('Name===>${item.name}');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ChatPage(
                                              itemUser,
                                              isChatFromRequestviewing: false,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    setWidth(5),
                                    createButton(
                                      height: 28,
                                      width: 70,
                                      fontSize: 13,
                                      borderRadius: BorderRadius.circular(14),
                                      txtColor: AppColors.white.lightColorHex(),
                                      text: 'Accept'.tr,
                                      onBtnClick: () async {
                                        //Stripe Payment
                                        // _openBottomSheetForMakePayment(item);

                                        final res =
                                            await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TelrPayment(
                                              item: item,
                                            ),
                                          ),
                                        );
                                        if (res != null) {
                                          await controller.acceptRejectOffer(
                                              true,
                                              '${controller.taskDetails?.id}',
                                              '${item.id}',
                                              paymentId: res);
                                        }

                                        // NavigationService().setNavigator(
                                        //   TelrPayment(),
                                        // );
                                      },
                                    ),
                                  ],
                                ),
                                setHeight(5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        )),
                                    child: setCommonText(
                                      item.description!,
                                      fontSize: 14,
                                      color: AppColors.black.lightColorHex(),
                                      fontWeight: FontWeight.w500,
                                      noOfLine: 5,
                                    ),
                                  ),
                                ),
                                setHeight(5),
                                Row(
                                  children: [
                                    setCommonText(
                                      item.createdAt!,
                                      fontSize: 12,
                                      color: AppColors.black.lightColorHex(),
                                      fontWeight: FontWeight.w500,
                                      noOfLine: 1,
                                    ),
                                    setWidth(7),
                                    // InkWell(
                                    //   onTap: () {
                                    //     con.openMessageWindow(index);
                                    //   },
                                    //   child: Row(
                                    //     children: [
                                    //       Icon(
                                    //         Icons.reply,
                                    //         size: 16,
                                    //         color: AppColors.colorPrimaryDark
                                    //             .lightColorHex(),
                                    //       ),
                                    //       setCommonText(
                                    //         'reply',
                                    //         fontSize: 12,
                                    //         color: AppColors.colorPrimaryDark
                                    //             .lightColorHex(),
                                    //         fontWeight: FontWeight.w800,
                                    //         noOfLine: 1,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                                setHeight(5),
                              ],
                            )),
                          ],
                        ),
                        setHeight(5),
                        CommentListWidget(index: index),
                        setHeight(5),
                        Divider(),
                      ],
                    );
                  }),
            ),
            setHeight(10),
            if ((con.taskDetails != null) &&
                (con.taskDetails!.quotations.length > 1)) ...[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: AppColors.colorPrimary.lightColorHex(),
                    )),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimaryDark.lightColorHex(),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: setCommonText(
                        'Auto Assign',
                        fontSize: 14,
                        color: AppColors.white.lightColorHex(),
                        fontWeight: FontWeight.w600,
                        noOfLine: 1,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () async {
                          ApiProvider()
                              .autoAssignContractor('${con.taskDetails?.id}')
                              .then((value) async {
                            if (value.message?.toLowerCase() == 'success') {
                              // open bottomsheet for payment.
                              debugPrint(
                                'Auto Assign data:${value.contractor?.toJson()}',
                              );
                              Quotations item = Quotations(
                                id: value.contractor?.id,
                                contractorId: value.contractor?.contractorId,
                                cost: value.contractor?.cost,
                                name: value.contractor?.name,
                              );
                              // _openBottomSheetForMakePayment(item);
                              final res = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TelrPayment(item: item),
                                ),
                              );
                              if (res != null) {
                                await controller.acceptRejectOffer(
                                    true,
                                    '${controller.taskDetails?.id}',
                                    '${item.id}',
                                    paymentId: res);
                              }
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: setCommonText(
                            'Assign'.tr,
                            fontSize: 15,
                            color: AppColors.black.lightColorHex(),
                            fontWeight: FontWeight.w500,
                            noOfLine: 1,
                            textAlignment: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    setHeight(10),
                    setCommonText(
                      'We\'ll assign the best professional',
                      fontSize: 14,
                      color: AppColors.gray.lightColorHex(),
                      fontWeight: FontWeight.w600,
                      noOfLine: 1,
                    ),
                    setHeight(10),
                  ],
                ),
              ),
              setHeight(30),
            ],
          ],
        );
      },
    );
  }
}
