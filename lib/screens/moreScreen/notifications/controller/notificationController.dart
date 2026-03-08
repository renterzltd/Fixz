// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_notificationList.dart';

class NotificationController extends GetxController {
  List<NotificationData> list = [];

  getLotificationList() async {
    ApiProvider _provider = ApiProvider();

    await _provider.getNotificationList().then((value) {
      list = value.notificationData!;
      update();
    });
  }
}
