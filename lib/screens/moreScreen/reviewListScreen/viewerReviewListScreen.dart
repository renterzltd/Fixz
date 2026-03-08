// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:get/get.dart';

import 'controller/reviewController.dart';

class MoreReviewListScreen extends StatefulWidget {
  const MoreReviewListScreen({Key? key}) : super(key: key);

  @override
  State<MoreReviewListScreen> createState() => _MoreNotificationScreenState();
}

class _MoreNotificationScreenState extends State<MoreReviewListScreen>
    with AppbarMixin {
  // List<Notification> notificationList = [];

  final controller = Get.put(ReviewController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationList = [
    //   Notification(
    //     description: 'Reviewed on  I need cleaner to clean my house',
    //     profile: dummyProfile,
    //     time: '15 days ago',
    //     title: 'the contractor is good.',
    //     review: '4.5',
    //   ),
    //   Notification(
    //     description: 'Jems A. commented on Clean & Repair my chairs',
    //     profile: dummyProfile,
    //     time: '25 days ago',
    //     title: 'Expected work as i want.',
    //     review: '5.0',
    //   ),
    //   Notification(
    //     description: 'Tony S. commented on I need cleaner to clean my Kitchen',
    //     profile: dummyProfile,
    //     time: '5 days ago',
    //     title: 'Work is good but took more time to complete it',
    //     review: '3.5',
    //   ),
    // ];
    controller.getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Review Screen'.tr,
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<ReviewController>(
        builder: (con) {
          return Container(
            color: Colors.white,
            child: con.reviewData.isNotEmpty
                ? ListView.builder(
                    itemCount: con.reviewData.length,
                    itemBuilder: (context, index) {
                      final item = con.reviewData[index];
                      return ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: setNetworkImage(dummyProfile, 60, 60),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText(
                                '${item.contractorName}${'commented on'.tr}${item.details}',
                                fontSize: 14,
                                noOfLine: 3,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                              setHeight(5),
                              setCommonText(
                                '${item.message}',
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
                                        item.reviews == null
                                            ? '0.0'
                                            : '${item.reviews}',
                                        fontSize: 13,
                                        noOfLine: 1,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  setWidth(8),
                                  setCommonText(
                                    '${item.created}',
                                    fontSize: 12,
                                    noOfLine: 1,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            ],
                          ));
                    })
                : Center(
                    child: setCommonText(
                      'Review Not Found'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class Notification {
  String title;
  String description;
  String profile;
  String time;
  String review;
  Notification(
      {this.title = "",
      this.description = "",
      this.profile = "",
      this.time = "",
      this.review = ""});
}
