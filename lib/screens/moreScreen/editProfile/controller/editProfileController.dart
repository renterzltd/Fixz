import 'dart:io';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  ApiProvider _provider = ApiProvider();
  XFile? imgFile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  fillData(String name, String email, String phone, String location) {
    nameController.text = name;
    emailController.text = email;
    mobileController.text = phone;
    locationController.text = location;

    update();
  }

  updateProfile() async {
    if (nameController.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter your name'.tr);
      return;
    }
    final param = {
      'name': nameController.text,
      'email': emailController.text,
      'postal_code': locationController.text,
      'mobile_number': mobileController.text,
    };

    try {
      await ApiProvider().updateProfile(param).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessTokenKey') ?? '';
      if (imgFile != null) {
        await ApiProvider()
            .uploadImage(File(imgFile?.path ?? ''), token)
            .then((value) {
          AlertClass.shared.setSnackbar('Profile updated successfully'.tr);
          NavigationService().setPopNavigator();
        });
      } else {
        AlertClass.shared.setSnackbar('Profile updated successfully'.tr);
        NavigationService().setPopNavigator();
      }
    });
    } catch (error){
      throw Exception('Error on update profile:$error');
    }


  }

  addPostalCode(String address) {
    locationController.text = address;
    update();
  }
}
