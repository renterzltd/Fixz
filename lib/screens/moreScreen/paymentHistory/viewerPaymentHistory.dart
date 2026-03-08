import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:get/get.dart';
import 'controller/paymentHistoryController.dart';

class ViewerPaymentHistory extends StatefulWidget {
  const ViewerPaymentHistory({Key? key}) : super(key: key);

  @override
  State<ViewerPaymentHistory> createState() => _MoreNotificationScreenState();
}

class _MoreNotificationScreenState extends State<ViewerPaymentHistory>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(PaymentHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Payment History'.tr,
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<PaymentHistoryController>(
        builder: (con) {
          return Container(
            color: Colors.white,
            child: con.paymentList.isNotEmpty
                ? ListView.builder(
                    itemCount: con.paymentList.length,
                    itemBuilder: (context, index) {
                      final item = con.paymentList[index];
                      return ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: setNetworkImage(dummyProfile, 60, 60),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText(
                                '${'Made Payment for'.tr} ${item.details}',
                                fontSize: 14,
                                noOfLine: 3,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                              setHeight(5),
                              setCommonText(
                                item.contractorName ?? '',
                                fontSize: 12,
                                noOfLine: 3,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              setHeight(8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      setCommonText(
                                        '${SharedManager.shared.getCurrency}${item.cost}',
                                        fontSize: 13,
                                        noOfLine: 1,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  setWidth(8),
                                  setCommonText(
                                    item.createdAt ?? '',
                                    fontSize: 12,
                                    noOfLine: 1,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              setHeight(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  createButton(
                                    height: 30,
                                    width: 120,
                                    text: '${item.status}',
                                    txtColor: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ));
                    })
                : Center(
                    child: setCommonText(
                      'Payment Not Found'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class Payment {
  String title;
  String description;
  String profile;
  String time;
  String cost;
  String taskStatus;
  Payment(
      {this.title = "",
      this.description = "",
      this.profile = "",
      this.time = "",
      this.cost = "",
      this.taskStatus = ""});
}
