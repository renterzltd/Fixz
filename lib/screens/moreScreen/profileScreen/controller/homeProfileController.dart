// ignore_for_file: unused_field, prefer_final_fields

import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';

class HomeProfileController extends GetxController {
  // Repository _repository = Provider.of(
  //     NavigationService.navigatorKey.currentContext!,
  //     listen: false);
  MyUser user = MyUser();
  ProfileData? profile;

  getProfileData() async {
    // user = _repository.getUser();
    await ApiProvider().getHomeProfileData().then((value) {
      if (value.message == 'success') {
        // log('data:${value.profileData!.profileImage!.first.documentName}');
        profile = value.data ?? ProfileData();
      } else {
        profile = ProfileData();
      }
      update();
    });
  }
}
