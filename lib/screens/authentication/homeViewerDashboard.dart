// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widget/socialMediaWidget.dart';

class HomeViewerDashboard extends StatefulWidget {
  const HomeViewerDashboard({Key? key}) : super(key: key);

  @override
  State<HomeViewerDashboard> createState() => _HomeViewerDashboardState();
}

class _HomeViewerDashboardState extends State<HomeViewerDashboard>
    with ButtonMixin {
  // VideoPlayerController _videoPlayerController =
  //     VideoPlayerController.asset("videos/home_video1.mp4");
  // Future<void>? _initializeVideoPlayerFuture;
  final panelController = PanelController();

  final loginController = Get.put(LoginController());

  bool isSelectRenterZ = true;
  bool isSelectRenterZKSA = false;
  bool isEnglish = true;

  String isFirstTime = '';

  void _getAppInstalationStatus() async {
    SharedManager.shared.STAGING_URL = await SharedManager.shared.getURL();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getString(DEFAULTKEYS.isFirstTimeInstalled) ?? '';
    final appStatus = prefs.getString(DEFAULTKEYS.isSelectedKSA);
    log("IS RenterZ App Selected:$isFirstTime");
    setState(() {});
  }

  @override
  void initState() {
    _getAppInstalationStatus();
    super.initState();
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repository _repository = Provider.of(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            isDraggable: false,
            controller: panelController,
            //    slideDirection:SlideDirection.DOWN,
            maxHeight: MediaQuery.of(context).size.height,
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.width * 0.65,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panelBuilder: (scrollController) => buildSlidingPanel(),
            body: Stack(
              children: <Widget>[
                //IWidget.iBackgroundPositioned(),
                Positioned(
                  top: 0,
                  // MediaQuery.of(context).size.height / 12,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: <Widget>[
                      // buildMap(context, model),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              APPIMAGES.sample,
                            )),
                        // child: VideoPlayer(_videoPlayerController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //If Is FirstTime is not Null we should not open the Application Selection Window
          //Note: Un-Comment this part when you want to add Localization

          // (isFirstTime == 'NO')
          //     ? SizedBox.fromSize()
          //     : Container(
          //         height: MediaQuery.of(context).size.height,
          //         width: MediaQuery.of(context).size.width,
          //         color: Colors.black87,
          //         padding: EdgeInsets.symmetric(horizontal: 30),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Select:',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //               textAlign: TextAlign.start,
          //             ),
          //             setHeight(15),
          //             setCommonButton(
          //                 title: 'Fixz UK',
          //                 status: isSelectRenterZ,
          //                 onClick: () async {
          //                   setState(() {
          //                     isSelectRenterZ = true;
          //                     isSelectRenterZKSA = false;
          //                   });
          //                   SharedPreferences prefs =
          //                       await SharedPreferences.getInstance();
          //                   await prefs.setString(
          //                       DEFAULTKEYS.isSelectedKSA, 'NO');
          //                 }),
          //             setHeight(20),
          //             setCommonButton(
          //                 status: isSelectRenterZKSA,
          //                 title: 'Fixz KSA',
          //                 onClick: () async {
          //                   setState(() {
          //                     isSelectRenterZ = false;
          //                     isSelectRenterZKSA = true;
          //                   });
          //                   SharedPreferences prefs =
          //                       await SharedPreferences.getInstance();
          //                   await prefs.setString(
          //                       DEFAULTKEYS.isSelectedKSA, 'YES');
          //                 }),
          //             isSelectRenterZKSA ? setLanguageOptions() : setHeight(0),
          //             setHeight(35),
          //             InkWell(
          //               onTap: () async {
          //                 SharedManager.shared.STAGING_URL = await getURL();
          //                 //Change language
          //                 if (!isEnglish) {
          //                   Get.updateLocale(Locale('ar', 'EG'));
          //                 }
          //                 SharedPreferences prefs =
          //                     await SharedPreferences.getInstance();
          //                 await prefs.setString(
          //                     DEFAULTKEYS.isFirstTimeInstalled, 'NO');
          //                 setState(() {
          //                   isFirstTime = 'NO';
          //                 });
          //               },
          //               child: Container(
          //                 height: 45,
          //                 width: double.infinity,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(5),
          //                   border: Border.all(
          //                     color: AppColors.colorPrimaryDark.lightColorHex(),
          //                   ),
          //                 ),
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   'SAVE',
          //                   style: TextStyle(
          //                     color: AppColors.white.lightColorHex(),
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
        ],
      ),
    );
  }

  Widget setLanguageOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setHeight(15),
        setCommonText(
          'Select Language:',
          color: Colors.white,
          fontSize: 17,
        ),
        setHeight(10),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isEnglish = true;
                });
              },
              child: Row(
                children: [
                  Icon(
                    isEnglish
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off_outlined,
                    color: Colors.white,
                  ),
                  setWidth(5),
                  setCommonText(
                    'English',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            setWidth(10),
            InkWell(
              onTap: () {
                setState(() {
                  isEnglish = false;
                });
              },
              child: Row(
                children: [
                  Icon(
                    !isEnglish
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off_outlined,
                    color: Colors.white,
                  ),
                  setWidth(5),
                  setCommonText(
                    'Arabic',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget setCommonButton(
      {required String title,
      required Function onClick,
      required bool status}) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.colorPrimaryDark.lightColorHex(),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.white.lightColorHex(),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              (status)
                  ? Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                      size: 20,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> checkNotificationPermission() async {
    var settings =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (settings?.didNotificationLaunchApp ?? false) {
      bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();
      return result ?? false;
    }
    return false;
  }

  // Future<void> _askForNotificationPermission() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Allow notifications?"),
  //       content: Text("We would like to send you notifications."),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop(false);
  //           },
  //           child: Text("Don't Allow"),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             // Navigator.of(context).pop(true);
  //             final PermissionStatus status =
  //                 await Permission.notification.request();
  //             log("Notification Status:$status");
  //             FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //                 FlutterLocalNotificationsPlugin();
  //             flutterLocalNotificationsPlugin
  //                 .resolvePlatformSpecificImplementation<
  //                     AndroidFlutterLocalNotificationsPlugin>()
  //                 ?.pendingNotificationRequests();
  //             final statuss = await checkNotificationPermission();
  //             log("Notification Status:$statuss");
  //           },
  //           child: Text("Allow"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildSlidingPanel() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 50,
            fit: BoxFit.fill,
            image: AssetImage(
              APPIMAGES.launchbg,
            ),
          ),
          setHeight(10),
          setCommonText(
            'Welcome to Maintenance Portal'.tr,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            noOfLine: 1,
          ),
          setHeight(10),
          setCommonText(
            'Feel safe and secure on Fixz'.tr,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            noOfLine: 5,
            color: AppColors.colorPrimaryDark.lightColorHex(),
          ),
          setHeight(20),
          Row(
            children: [
              Expanded(
                child: createButton(
                    borderRadius: BorderRadius.circular(20),
                    height: 40,
                    text: 'Log in'.tr,
                    txtColor: AppColors.White.lightColorHex(),
                    onBtnClick: () {
                      NavigationService().setNavigator(HomeviewerLogin());
                    }),
              ),
              setWidth(20),
              Expanded(
                child: InkWell(
                  onTap: () {
                    NavigationService().setNavigator(HomeviewerSignup());
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.white.lightColorHex(),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.colorPrimary.lightColorHex(),
                        )),
                    alignment: Alignment.center,
                    child: setCommonText(
                      'Sign up'.tr,
                      color: AppColors.colorPrimary.lightColorHex(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SocialMediaButtons()
        ],
      ),
    );
  }
}

// assets/images/google.png
// assets/images/facebook.png
// assets/images/apple.png