// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

// import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/localizations/localizations.dart';
import 'package:fixz/screens/splashScreen/splashScreen.dart';
// import 'package:new_version/new_version.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'di/provider_setup.dart';

// late NewVersion newVersion;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // newVersion = NewVersion();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(MyApp(sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  MyApp(this.sharedPreferences);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // newVersion.showAlertIfNecessary(context: context);
    return MultiProvider(
      providers: appProviders(widget.sharedPreferences),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FixZ',
        home: SplashScreen(),
        // home: LegacyTokenCardScreen(),
        navigatorKey: NavigationService.navigatorKey,
        builder: EasyLoading.init(),
        translations: MyLocalizations(),
        locale: Locale('en', 'US'),
      ),
    );
  }
}
