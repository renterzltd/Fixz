// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:get/get.dart';

import 'controller/notificationController.dart';

class MoreNotificationScreen extends StatefulWidget {
  const MoreNotificationScreen({Key? key}) : super(key: key);

  @override
  State<MoreNotificationScreen> createState() => _MoreNotificationScreenState();
}

class _MoreNotificationScreenState extends State<MoreNotificationScreen>
    with AppbarMixin {
  List<Notification> notificationList = [];
  final controller = Get.put(NotificationController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   notificationList = [
  //     Notification(
  //         description:
  //             'Brenda F. commented on I need cleaner to clean my house',
  //         profile: dummyProfile,
  //         time: '15 days ago',
  //         title: ''),
  //     Notification(
  //         description: 'Jems A. commented on I need cleaner to clean my house',
  //         profile: dummyProfile,
  //         time: '25 days ago',
  //         title: ''),
  //     Notification(
  //         description: 'Tony S. commented on I need cleaner to clean my house',
  //         profile: dummyProfile,
  //         time: '5 days ago',
  //         title: ''),
  //   ];
  // }

  @override
  void initState() {
    super.initState();
    controller.getLotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Notifications'.tr,
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<NotificationController>(
        builder: (con) {
          return Container(
            color: Colors.white,
            child: con.list.length > 0
                ? ListView.builder(
                    itemCount: con.list.length,
                    itemBuilder: (context, index) {
                      final item = con.list[index];
                      return ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: setNetworkImage(dummyProfile, 50, 50),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText(
                                item.title ?? '',
                                fontSize: 14,
                                noOfLine: 3,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                              ),
                              setHeight(8),
                              setCommonText(
                                item.createdAt.toString(),
                                fontSize: 12,
                                noOfLine: 1,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ));
                    })
                : Center(
                    child: setCommonText(
                      'Notifications Not Found'.tr,
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

class Notification {
  String title;
  String description;
  String profile;
  String time;
  Notification(
      {this.title = "",
      this.description = "",
      this.profile = "",
      this.time = ""});
}
