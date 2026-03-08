import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:fixz/common_view/common_alert_with_message_title.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_dispute_request_list.dart';
import 'package:fixz/screens/moreScreen/controller/more_controller.dart';
import 'package:flutter/cupertino.dart';

class DisputeDetailsPage extends StatelessWidget with ButtonMixin {
  final DisputeRequestData item;
  const DisputeDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: AppColors.colorPrimaryDark.lightColorHex()),
        backgroundColor: AppColors.white.lightColorHex(),
        title: setCommonText(
          'Dispute Details'.tr,
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 1.0,
      ),
      body: GetBuilder<MoreController>(
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _setCommonWidgetTitleWithValue(
                            title: 'Job Title:', value: '${item.jobTitle}'),
                        setHeight(10),
                        _setCommonWidgetTitleWithValue(
                          title: 'Description:',
                          value: '${item.jobDescription}',
                        ),
                        setHeight(10),
                        setCommonText(
                          'Dispute Reason:',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        setHeight(5),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.gray1.lightColorHex()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: con.reasonController,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              // labelText: 'Write comment'.tr,
                              border: InputBorder.none,
                              hintText: 'Write your reason here...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                        setHeight(10),
                        if (item.images?.isNotEmpty ?? false) ...[
                          setCommonText(
                            ' Dispute Picture:',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          setHeight(10),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: List<Widget>.generate(
                                item.images?.length ?? 0, (index) {
                              final img = item.images?[index];

                              return GridTile(
                                child: DottedBorder(
                                  color: AppColors.gray.lightColorHex(),
                                  padding: const EdgeInsets.all(1),
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: img?.documentName ?? '',
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          setHeight(10),
                        ],
                        if (item.status.toString() == '9')
                          setCommonText(
                            'Dispute Request Cancelled',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        if (item.status.toString() == '1')
                          setCommonText(
                            'Dispute Request Resolved',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        if (item.status.toString() == '2')
                          setCommonText(
                            'Dispute Request in Progress',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                      ],
                    ),
                  ),
                ),
                setHeight(10),
                if (item.status.toString() == '0') ...[
                  Row(
                    children: [
                      Expanded(
                        child: createButton(
                          hideGradient: true,
                          btnColour: AppColors.colorPrimaryDark.lightColorHex(),
                          text: 'CANCEL',
                          txtColor: AppColors.white.lightColorHex(),
                          height: 50,
                          weightFont: FontWeight.w600,
                          onBtnClick: () {
                            showAlertDialogWithMessage(context,
                                title: 'Cancel Dispute Request?',
                                message:
                                    'If you want to cancel the dispute then you no longer able to raise for this job',
                                onTap: (val) {
                              log('val:$val');
                              if (val) {
                                con.updateDisputeRequest(
                                  reportId: '${item.id}',
                                  isCancel: true,
                                  context: context,
                                );
                              }
                            });
                          },
                        ),
                      ),
                      setWidth(20),
                      Expanded(
                        child: createButton(
                          hideGradient: true,
                          btnColour: AppColors.colorPrimaryDark.lightColorHex(),
                          text: 'RESOLVE',
                          txtColor: AppColors.white.lightColorHex(),
                          height: 50,
                          weightFont: FontWeight.w600,
                          onBtnClick: () {
                            showAlertDialogWithMessage(context,
                                title: 'Resolve Dispute Request?',
                                message:
                                    'Are you sure you want to resolve dispute request?',
                                onTap: (val) {
                              log('val:$val');
                              if (val) {
                                con.updateDisputeRequest(
                                  reportId: '${item.id}',
                                  isCancel: false,
                                  context: context,
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  setHeight(10),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  showAlertDialogWithMessage(
    BuildContext context, {
    required String title,
    required String message,
    Function(bool)? onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonAlertWithMessage(
          title: title,
          message: message,
          onTap: (val) {
            NavigationService().setPopNavigator();
            onTap?.call(val);
          },
        );
      },
    );
  }

  _setCommonWidgetTitleWithValue({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          title,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        setCommonText(
          value,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.gray_mid.lightColorHex(),
          noOfLine: 20,
        ),
        const Divider()
      ],
    );
  }
}
