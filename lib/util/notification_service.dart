// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/taskDetails/bookingTaskDetails/bookingTaskDetails.dart';
import 'package:fixz/screens/taskDetails/taskDetails/taskDetails/taskDetails.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    // Initialize LocalNotification Plugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Android Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'high_importance_channel Importance Notifications', // description
      importance: Importance.high,
    );

    // Create Channel - Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // App Icon - Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        // AndroidInitializationSettings('launch_background');
        AndroidInitializationSettings('notiicon');

    // IOS Settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      defaultPresentBadge: false,
      requestSoundPermission: false,
      requestBadgePermission: true,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // Initialize Both Platform's Settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (message != null) {
        final data = message.data['data'];
        final jsonData = jsonDecode(data);
        debugPrint('EVENT =======>:$message');
        debugPrint('Branch Id:${jsonData['job_id']}');
        debugPrint('Branch Name:${jsonData['type']}');

        Future.delayed(Duration(milliseconds: 200), () async {
          await prefs.setBool('isKillMode', true);
          await prefs.setString('jobId', jsonData['job_id'].toString());
          await prefs.setString('jobType', jsonData['type'].toString());

          // await NavigationService().setNavigator(NotificationRedirection(
          //   title: 'Job ID is:${jsonData['job_id']}',
          // ));
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      if (message.notification != null) {
        String? title = message.notification?.title;
        String? body = message.notification?.body;
        flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            title,
            body,
            // ignore: prefer_const_constructors
            NotificationDetails(
              android: AndroidNotificationDetails("Fixz", "Fixz",
                  priority: Priority.max, importance: Importance.max),
              iOS: DarwinNotificationDetails(
                presentSound: true,
                presentAlert: true,
              ),
            ),
            payload: jsonEncode(message.data));
        debugPrint('Notification Msg : $title $body');
        if (message.data.isNotEmpty) {
          debugPrint(
              'Message also contained a notification: ${message.data["data"]}');
        }
      }
    });

    //THIS IS FOR BACKGROUND STUFF
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      // AlertClass.shared.setSnackbar('App opend from the background: $event');
      final data = event.data['data'];
      final jsonData = jsonDecode(data);

      debugPrint('EVENT =======>:$jsonData');
      debugPrint('Branch Id:${jsonData['job_id']}');
      debugPrint('Branch Name:${jsonData['type']}');
      if (!SharedManager.shared.isNavigateBG) {
        SharedManager.shared.isNavigateBG = true;
        _setScreensNavigations(
            jsonData['job_id'].toString(), jsonData['type'].toString());
        // Future.delayed(Duration(milliseconds: 200), () async {
        //   await NavigationService().setNavigator(NotificationRedirection(
        //     title: 'From 91',
        //   ));
        // });
      }
    });
  }

  // OnTap Android Local Notification
  Future selectNotification(String? payload) async {
    if (payload != null) {
      // debugPrint("ANDROID TAP NOTIFICATION $payload");
      final jsonData = await jsonDecode(payload);
      String finalPayload = await jsonData['data'];
      debugPrint('EVENT TAP FORGROUND =======>:$finalPayload');
      final jsonObject = jsonDecode(finalPayload);
      debugPrint('Json Object =======>:$jsonObject');

      debugPrint('FORGROUND Id:${jsonObject['job_id']}');
      debugPrint('FORGROUND Name:${jsonObject['type']}');

      _setScreensNavigations(
          jsonObject['job_id'].toString(), jsonObject['type'].toString());

      // try {
      //MARK: Screen Navigation When app is FG
      // if (jsonObject['type'].toString().toLowerCase() == 'new quotation') {
      //   Future.delayed(Duration(milliseconds: 200), () {
      //     NavigationService().setNavigator(TaskDetails(
      //       taskId: jsonObject['job_id'].toString(),
      //     ));
      //   });
      // } else if (jsonObject['type'].toString().toLowerCase() == 'job done') {
      //   Future.delayed(Duration(milliseconds: 200), () {
      //     NavigationService().setNavigator(BookingTaskDetails(
      //       taskId: jsonObject['job_id'].toString(),
      //     ));
      //     // NavigationService().setNavigator(NotificationRedirection(
      //     //   title: 'From 112',
      //     // ));
      //   });
      // }
      // } catch (e) {
      //   debugPrint(e);
      // }
    }
  }

  // OnTap IOS Local Notification
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    if (payload != null) {
      debugPrint("IOS TAP NOTIFICATION $payload");
      try {
        // _setNavigationScreen();
        // await NavigationService().setNavigator(NotificationRedirection(
        //   title: 'From 128',
        // ));
      } catch (e) {
        debugPrint('Error:$e');
      }
    }
  }

  _setScreensNavigations(String status, String jobType) {
    // SharedManager.shared.isNavigateBG = false;
    if (jobType.toLowerCase() == 'new quotation') {
      Future.delayed(Duration(milliseconds: 200), () {
        NavigationService().setNavigator(TaskDetails(
          taskId: status,
        ));
      });
    } else if (jobType.toLowerCase() == 'job done') {
      Future.delayed(Duration(milliseconds: 200), () {
        NavigationService().setNavigator(BookingTaskDetails(
          taskId: status,
        ));
        // NavigationService().setNavigator(NotificationRedirection(
        //   title: 'From 112',
        // ));
      });
    }
  }

  _setNavigationScreen() async {
    // Repository _repository = Provider.of(
    //     NavigationService.navigatorKey.currentContext!,
    //     listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final status = prefs.getString('isHomeViewerLogin') ?? 'no';
    // log('******************STSTUS*******************$status');
    // if (status.toLowerCase() == 'yes') {
    //   currentIndexHomeViewer = 0;
    //   NavigationService().setNavigator(HomeTabbarScreen(), isFullScreen: true);
    //   return;
    // }

    // if (_repository.getUserType() == "LandLoard") {
    //   indexSelected = 2;
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     indexSelected = 2;
    //     debugPrint('Landoard====>');
    //     Navigator.of(NavigationService.navigatorKey.currentContext!)
    //         .pushNamedAndRemoveUntil(
    //             RoutePaths.HomeScreen, (Route<dynamic> route) => false);
    //   });
    // } else {
    //   Future.delayed(const Duration(milliseconds: 100), () {
    //     indexSelected = 3;
    //     Navigator.of(NavigationService.navigatorKey.currentContext!)
    //         .pushNamedAndRemoveUntil(
    //             RoutePaths.HomeScreen, (Route<dynamic> route) => false);
    //   });
    // }
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  String? title = message.notification?.title;
  String? body = message.notification?.body;
  debugPrint("Handling a background message: $title $body");
  if (message.data.isNotEmpty) {
    debugPrint('Handling a background message: ${message.data}');
  }
}

navigateToScreen(Map<String, dynamic> data) {
  debugPrint("Navigate to Screen");
  String type = data["type"];
  debugPrint("Redirection Type : $type");
}

class NotificationRedirection extends StatefulWidget {
  final String? title;
  const NotificationRedirection({Key? key, required this.title})
      : super(key: key);

  @override
  State<NotificationRedirection> createState() =>
      _NotificationRedirectionState();
}

class _NotificationRedirectionState extends State<NotificationRedirection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedManager.shared.isNavigateBG = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? '',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Container(),
    );
  }
}
