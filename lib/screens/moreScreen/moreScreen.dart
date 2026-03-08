// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/selectLanguages/languagesScreen.dart';
import 'package:flutter/foundation.dart';
import 'helpOptions/helpOptionsScreen.dart';
import 'notifications/moreNotification.dart';
import 'paymentHistory/viewerPaymentHistory.dart';
import 'profileScreen/homeViewerProfile.dart';
import 'reviewListScreen/viewerReviewListScreen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with AppbarMixin {
  List<MOREOPTION> moreOption = [];

  _checkKSAAPPSelectedOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final status = prefs.getString(DEFAULTKEYS.isSelectedKSA);
    if (status != null) {
      if (status == 'YES') {
        moreOption.insert(
          4,
          MOREOPTION(
            isSelect: false,
            title: 'Change Language'.tr,
            iconData: Icons.language,
            isLogout: false,
            screen: LanguagesScreen(),
          ),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    moreOption = [
      MOREOPTION(
          isSelect: false,
          title: 'Profile'.tr,
          iconData: Icons.person,
          isLogout: false,
          screen: HomeViewerProfileScreen()),
      // MOREOPTION(isSelect:false,title:'Payment History'),
      MOREOPTION(
          isSelect: false,
          title: 'Review Screen'.tr,
          iconData: Icons.reviews,
          isLogout: false,
          screen: MoreReviewListScreen()),
      MOREOPTION(
          isSelect: false,
          title: 'Notification'.tr,
          iconData: Icons.notifications,
          isLogout: false,
          screen: MoreNotificationScreen()),
      MOREOPTION(
          isSelect: false,
          title: 'Payment History'.tr,
          iconData: Icons.history,
          isLogout: false,
          screen: ViewerPaymentHistory()),
      // MOREOPTION(
      //     isSelect: false,
      //     title: 'Notification Settings',
      //     iconData: Icons.settings,
      //     isLogout: false),
      MOREOPTION(
          isSelect: false,
          title: 'Help'.tr,
          iconData: Icons.support_agent,
          isLogout: false,
          screen: HelpOptionScreen()
          // screen: WebViewPage(
          //   title: 'Help',
          //   webURL: 'https://www.google.com/',
          //   isGoogle: false,
          // ),
          ),
      // MOREOPTION(
      //     isSelect: false,
      //     title: 'Ejar',
      //     iconData: Icons.app_registration,
      //     isLogout: false,
      //     screen: HomeWebViewSceen(
      //       title: 'Ejar Registration',
      //       webUrl: 'https://eservices.ejar.sa/en/public/landing',
      //     )),
      MOREOPTION(
          isSelect: false,
          title: 'Logout'.tr,
          iconData: Icons.logout,
          isLogout: true),
      // MOREOPTION(
      //   isSelect: false,
      //   title: SharedManager.shared.STAGING_URL,
      //   iconData: Icons.logout,
      //   isLogout: true,
      // ),
      // MOREOPTION(
      //   isSelect: false,
      //   title: 'Release Status:$kReleaseMode',
      //   iconData: Icons.logout,
      //   isLogout: true,
      // ),
    ];
    _checkKSAAPPSelectedOrNot();
  }

  _makeLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await EasyLoading.show(status: 'Loading...'.tr);
    ApiProvider _apiProvider = ApiProvider();
    final token = prefs.getString('accessTokenKey')!;
    await _apiProvider.logout(token).then((value) async {
      await EasyLoading.dismiss();
      LocalStorageProvider localStorage = LocalStorageProvider(prefs);
      await localStorage.clearData();
      await localStorage.clearUser();
      await prefs.setString('isHomeViewerLogin', 'no');
      NavigationService()
          .setNavigator(HomeViewerDashboard(), isRemoveAll: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.colorPrimaryDark.lightColorHex(),
          centerTitle: false,
          title: setCommonText(
            'More Options'.tr,
            color: AppColors.white.lightColorHex(),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        // setAppbar(
        //   'More Options',
        //   bgColor: AppColors.colorPrimaryDark.lightColorHex(),
        //   textColor: AppColors.white.lightColorHex(),
        //   onBackClick: () {},
        // ),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: moreOption.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (moreOption[index].screen != null) {
                        NavigationService()
                            .setNavigator(moreOption[index].screen!);
                      } else if (moreOption[index].isDelete) {
                        // AlertClass.shared.shoAlertWindow(
                        //     "Are you sure you want to delete your account?".tr,
                        //     buttonPress: (status) async {
                        //   if (status) {
                        //     log("user deleted");
                        //     //Delete api call
                        //     ApiProvider().deleteUserRole().then((value) {
                        //       if (value != null) {
                        //         AlertClass.shared.setSnackbar(
                        //             'The account has been disabled and will be deleted in 30 days. If this is by mistake, please contact Fizx support.');
                        //         _makeLogout();
                        //       }
                        //     });
                        //   }
                        // });
                      } else {
                        AlertClass.shared.shoAlertWindow(
                            "Are you sure you want to logout?".tr,
                            buttonPress: (status) async {
                          if (status) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (SharedManager.shared.isSocialLogin) {
                              await SharedManager.shared.googleSignIn.signOut();
                              await prefs.setString('isHomeViewerLogin', 'no');
                              NavigationService().setNavigator(
                                  HomeViewerDashboard(),
                                  isRemoveAll: true);
                              return;
                            }
                            _makeLogout();
                          }
                        });
                      }
                    },
                    title: setCommonText(
                      moreOption[index].title,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: moreOption[index].isLogout!
                          ? Colors.transparent
                          : Colors.grey.shade400,
                      size: 16,
                    ),
                    leading: Icon(
                      moreOption[index].iconData,
                      color: Colors.grey,
                      size: 20,
                    ),
                  );
                })),
      ),
    );
  }
}

class MOREOPTION {
  String title;
  bool isSelect;
  bool isDelete;
  IconData? iconData;
  bool? isLogout;
  Widget? screen;

  MOREOPTION({
    this.title = "",
    this.isSelect = false,
    this.isDelete = false,
    this.iconData,
    this.isLogout,
    this.screen,
  });
}
