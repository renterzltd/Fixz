import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/place_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SharedManager {
  static final SharedManager _singleton = SharedManager._internal();
  factory SharedManager() => _singleton;
  SharedManager._internal();
  static SharedManager get shared => _singleton;

  bool isSocialLogin = false;
  bool isNavigateBG = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var latitude = 22.23440877046097;
  var longitude = 70.79147297639359;
  // latitude: '22.23440877046097',
  //longitude: '70.79147297639359',
  int updateDriver = 10;

  // String STAGING_URL = 'https://renterz.com/api/'; // UK VERSION-PRODUCTION
  // String STAGING_URL = 'https://renterz.ae/api/'; // DUBAI VERSION-PRODUCTION
  // String STAGING_URL = 'https://dev.renterz.com/api/'; //DEV FOR BOTH

  String STAGING_URL = '';

  // String countryCode = 'GB';
  String countryCode = 'AE';
  get isDubaiVersion => (countryCode.toLowerCase() == 'ae');

  get getCurrency => !isDubaiVersion ? '£' : 'AED ';

  get getPaymentCurrency => !isDubaiVersion ? 'USD' : 'aed ';

  Future<String> getURL() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final status = prefs.getString(DEFAULTKEYS.isSelectedKSA) ?? '';
    // log('Application Status:$status');
    if (SharedManager.shared.isDubaiVersion) {
      return kReleaseMode
          ? 'https://renterz.ae/api/'
          : 'https://dev.renterz.com/api/';
      // return
      // Live(UK) 'https://renterz.com/api/';
      // Live(DUBAI) 'https://renterz.ae/api/';
      //  Dev  https://dev.renterz.com/api/
    } else {
      return kReleaseMode
          ? 'https://renterz.ae/api/'
          : 'https://dev.renterz.com/api/';
    }
  }

  Future<LocationResult?> showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PlacePicker('YOUR_GOOGLE_MAPS_API_KEY'),
        fullscreenDialog: false,
      ),
    );
    return result;
  }

  Future<String?> getVideoThumbnail(String thumbnailVideo) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: thumbnailVideo,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      // maxHeight:
      //     64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    return fileName;
  }

  openSocialMediaProfile(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  //GET JSON FILE URL

  String getJsonFileURL(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'repair':
        return 'assets/animatedIcons/repair-tools.json';
      case 'cleaning':
        return 'assets/animatedIcons/cleaning-tools.json';
      case 'locksmith':
        return 'assets/animatedIcons/door-lock.json';
      case 'gardening/landscaping':
        return 'assets/animatedIcons/digging.json';
      case 'furniture assembly':
        return 'assets/animatedIcons/shelves.json';
      case 'furniture movers':
        return 'assets/animatedIcons/truck.json';
      case 'handyman services':
        return 'assets/animatedIcons/mechanic.json';
      case 'pest control':
        return 'assets/animatedIcons/insecticide.json';
      case 'painting':
        return 'assets/animatedIcons/paint-roller.json';
      case 'marble polishing':
        return 'assets/animatedIcons/small-polisher_f.json';
      case 'a/c duct cleaning':
        return 'assets/animatedIcons/air-conditioner.json';
      case 'a/c units servicing':
        return 'assets/animatedIcons/air-conditioner-b.json';
      case 'water tanks cleaning and disinfection':
        return 'assets/animatedIcons/water-tower.json';
      case 'plumbing':
        return 'assets/animatedIcons/tap.json';
      case 'electrical':
        return 'assets/animatedIcons/unplugged.json';
      case 'air conditioning':
        return 'assets/animatedIcons/air-conditioner-a.json';
      case 'appliances repair':
        return 'assets/animatedIcons/home-appliance.json';
      case 'pumps repair':
        return 'assets/animatedIcons/air-pump.json';
      default:
        return 'assets/animatedIcons/repair-tools.json';
    }
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    MyUser user = localStorage.getUser();
    return user.name;
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    MyUser user = localStorage.getUser();
    return user.email;
  }

  Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalStorageProvider localStorage = LocalStorageProvider(prefs);
    MyUser user = localStorage.getUser();
    return user.mobileNumber;
  }
}

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key='YOUR_GOOGLE_MAPS_API_KEY'}";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    Map values = jsonDecode(response.body);

    return values["routes"][0]["overview_polyline"]["points"];
  }
}

Future<bool> willPopCallback({bool isExitApp = false}) async {
  if (isExitApp) {
    AlertClass.shared.shoAlertWindow('Are you sure you want to exit the app?',
        buttonPress: (status) {
      if (status) {
        exit(0);
      }
    });
  } else {
    currentIndexHomeViewer = 0;
    return NavigationService()
        .setNavigator(const HomeTabbarScreen(), isRemoveAll: true);
  }
  return Future.value(true);
}

Future<bool> checkNotificationService() async {
  final status = await Permission.notification.isDenied;
  return status;
}

storeValue({required String key, required String value}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(key, value);
}

Future<String?> getValue({required String key}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final value = pref.getString(key) ?? '';
  return value;
}

openwhatsapp() async {
  const contact = '+447570000827';
  const androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
  final iosUrl =
      "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    AlertClass.shared.setSnackbar('WhatsApp is not installed.');
  }
}
