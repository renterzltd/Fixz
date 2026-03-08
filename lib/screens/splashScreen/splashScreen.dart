// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/model_get_ip.dart';
import 'package:fixz/screens/onBoard/getStartScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _setWidgetStatus() async {
    SharedManager.shared.STAGING_URL = await SharedManager.shared.getURL();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final status = prefs.getString('isHomeViewerLogin') ?? '';
    final isFirstTime = prefs.getString('isFirstTime') ?? '';
    if (isFirstTime != 'yes') {
      return NavigationService()
          .setNavigator(GetStartScreen(), isRemoveAll: true);
    } else {
      if (status == 'yes') {
        return NavigationService()
            .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
      } else {
        return NavigationService()
            .setNavigator(HomeViewerDashboard(), isRemoveAll: true);
      }
    }
  }

  _getIPAddress() async {
    final dio = Dio();
    final response = await dio.get('https://freeipapi.com/api/json');
    final ipData = ModeGetIP.fromJson(response.data);
    SharedManager.shared.countryCode = ipData.countryCode ?? '';
    log("IP DETAILS:${response.data}");
    log('SharedManager.instance.countryCode:${SharedManager.shared.countryCode}');
  }

  @override
  void initState() {
    super.initState();
    // Temperory comment
    // _getIPAddress();
    _setWidgetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(alignment: Alignment.center, color: Colors.white),
    );
  }
}
