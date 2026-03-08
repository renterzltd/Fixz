// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/moreScreen/editProfile/editProfile.dart';

import 'controller/homeProfileController.dart';

class HomeViewerProfileScreen extends StatefulWidget {
  const HomeViewerProfileScreen({Key? key}) : super(key: key);

  @override
  State<HomeViewerProfileScreen> createState() =>
      _HomeViewerProfileScreenState();
}

class _HomeViewerProfileScreenState extends State<HomeViewerProfileScreen>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(HomeProfileController());

  _setCommonColumnWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black.lightColorHex()),
        setHeight(5),
        setCommonText(
          value,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.gray.lightColorHex(),
          noOfLine: 2,
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfileData();
  }

  _makeLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await EasyLoading.show(status: 'Loading...'.tr);
    final token = prefs.getString('accessTokenKey')!;
    await ApiProvider().logout(token).then((value) async {
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
    return Scaffold(
      appBar: setAppbar('My Profile'.tr,
          backIconColor: Colors.white,
          textColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: Container(
        color: AppColors.white.lightColorHex(),
        padding: EdgeInsets.all(25),
        child: GetBuilder<HomeProfileController>(
          builder: (con) {
            return con.profile == null
                ? SizedBox.shrink()
                : ListView(
                    children: [
                      setHeight(15),
                      Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: (con.profile?.profileImage != null)
                                ? setNetworkImage(
                                    (con.profile!.profileImage!.isNotEmpty)
                                        ? con.profile?.profileImage ??
                                            dummyProfile
                                        : dummyProfile,
                                    100,
                                    100)
                                : setHeight(0),
                          )),
                      setHeight(30),
                      _setCommonColumnWidget(
                          'Name:'.tr, con.profile?.name ?? ''),
                      setHeight(10),
                      _setCommonColumnWidget(
                          'Email:'.tr, con.profile?.email ?? ''),
                      setHeight(10),
                      _setCommonColumnWidget(
                          'Mobile:'.tr, con.profile?.mobileNumber ?? ''),
                      setHeight(10),
                      _setCommonColumnWidget('Location:'.tr,
                          con.profile?.postalCode ?? 'Location not found'.tr),
                      setHeight(80),
                      createButton(
                          text: 'Update Profile'.tr,
                          txtColor: Colors.white,
                          onBtnClick: () async {
                            var profileUrl = dummyProfile;
                            if ((con.profile?.profileImage != null)) {
                              if ((con.profile!.profileImage!.isNotEmpty)) {
                                profileUrl =
                                    con.profile?.profileImage ?? dummyProfile;
                              }
                            }
                            await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(
                                          email: con.profile?.email,
                                          image: profileUrl,
                                          location: con.profile?.postalCode,
                                          name: con.profile?.name,
                                          phone: con.profile?.mobileNumber,
                                        )))
                                .then((value) {
                              controller.getProfileData();
                            });
                          }),
                      setHeight(15),
                      InkWell(
                          onTap: () {
                            AlertClass.shared.shoAlertWindow(
                                "Are you sure you want to delete your account?"
                                    .tr, buttonPress: (status) async {
                              if (status) {
                                //Delete api call
                                ApiProvider().deleteUserRole().then((value) {
                                  if (value != null) {
                                    AlertClass.shared.setSnackbar(
                                        'The account has been disabled and will be deleted in 30 days. If this is by mistake, please contact Fizx support.');
                                    _makeLogout();
                                  }
                                });
                              }
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: setCommonText(
                              'Delete User',
                              color: AppColors.red.lightColorHex(),
                            ),
                          )),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
