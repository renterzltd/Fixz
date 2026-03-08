// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty, avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/flutter_app_version_checker.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/taskCreationScreens/categoryScreen/categoryScreen.dart';
import 'package:fixz/screens/taskDetails/bookingTaskDetails/bookingTaskDetails.dart';
import 'package:fixz/screens/taskDetails/taskDetails/taskDetails/taskDetails.dart';
import 'package:fixz/screens/taskListScreen/widgets/bookinListWidgets.dart';
import 'package:fixz/screens/taskListScreen/widgets/taskListWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/taskListController.dart';
import 'forceUpdate/force_update_popup.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final controller = Get.put(TaskListController());

  final _versionChecker = AppVersionChecker(
    appId: Platform.isAndroid ? "com.app.fixz" : 'com.app.fixz',
  );

  _setBGWidgetStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool killStatus = prefs.getBool('isKillMode') ?? false;
    final jobId = prefs.getString('jobId') ?? '';
    final jobType = prefs.getString('jobType') ?? '';

    log('killStatus=>$killStatus');
    log('jobId=>$jobId');
    log('jobType=>$jobType');

    if (killStatus) {
      await prefs.setBool('isKillMode', false);
      _setScreensNavigations(jobId, jobType);
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

  _setAllMethods() async {
    tabController = TabController(length: 2, vsync: this);
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    Repository _repository = Provider.of(context, listen: false);
    await _setBGWidgetStatus();

    _firebaseMessaging.getToken().then((token) async {
      log('******************* TOKEN FROM HOMEVIEWER****************\n$token\n');
      log('******************* TOKEN FROM HOMEVIEWER END****************\n');
      ApiResponse response = await _repository.updateFcmToken(token ?? "");

      debugPrint(response.data);
      debugPrint('{response.isCompleted()}');
    });
  }

  _checkLanguageStatuAndKSAStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final lan = prefs.getString(DEFAULTKEYS.selectedLanguage);
    if (lan != null) {
      EasyLoading.dismiss();
      if (lan == 'English') {
        Get.updateLocale(Locale('en', 'US'));
      } else {
        Get.updateLocale(Locale('ar', 'EG'));
      }
    }
  }

  checkNotificationPermission() async {
    log('Notification Status:${await Permission.notification.isGranted}');
    if (!await Permission.notification.isGranted) {
      showNotificationPermissionDialog(context);
    }
  }

  _openBottomsheetforForceUpdate(String url) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        builder: (builder) {
          return Container(
            color: Colors.transparent,
            child: ForceUpdatePopup(
              webUrl: url,
            ),
          );
        });
  }

  @override
  void initState() {
    //this is for notification permission.
    checkNotificationPermission();
    //this is for language
    _checkLanguageStatuAndKSAStatus();
    super.initState();
    _setAllMethods();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkVersion();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    //bottomController.dispose();
    super.dispose();
  }

  void checkVersion() async {
    await Future.wait([
      _versionChecker.checkUpdate().then((value) {
        log('version value is:$value');
        if (value.canUpdate) {
          _openBottomsheetforForceUpdate(value.appURL ?? '');
        }
      }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskListController>(
      builder: (con) {
        return WillPopScope(
          onWillPop: () => willPopCallback(isExitApp: true),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.colorPrimaryDark.lightColorHex(),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                  child: InkWell(
                    onTap: () async {
                      openwhatsapp();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.whatsapp,
                            color: AppColors.white.lightColorHex()),
                        setHeight(3),
                        Text(
                          'Support'.tr,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: AppColors.white.lightColorHex(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              title: setCommonText('My tasks'.tr,
                  color: AppColors.white.lightColorHex(),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              bottom: TabBar(
                indicatorColor: AppColors.gray.lightColorHex(),
                controller: tabController,
                tabs: <Tab>[
                  // ignore: prefer_const_constructors
                  Tab(
                    text: 'New Job Request'.tr,
                  ),
                  Tab(
                    text: 'Accepted Job'.tr,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                TasksWidgets(),
                BookingWidgets(),
              ],
            ),
            floatingActionButton: con.taskList.length > 0
                ? FloatingActionButton.extended(
                    backgroundColor: AppColors.colorPrimaryDark.lightColorHex(),
                    foregroundColor: AppColors.colorPrimaryDark.lightColorHex(),
                    onPressed: () {
                      NavigationService().setNavigator(CategoryScreen());
                      // NavigationService().setNavigator(CreateNewTask());
                    },
                    icon: Icon(
                      Icons.note_add,
                      color: AppColors.white.lightColorHex(),
                    ),
                    label: setCommonText(
                      'Create Task'.tr,
                      color: AppColors.white.lightColorHex(),
                      fontSize: 15,
                      textAlignment: TextAlign.center,
                    ),
                  )
                : setWidth(0),
          ),
        );
      },
    );
  }
}
