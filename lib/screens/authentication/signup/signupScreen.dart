// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:country_picker/country_picker.dart';
import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/authentication/widget/socialMediaWidget.dart';
// import 'package:sms_autofill/sms_autofill.dart';

class HomeviewerSignup extends StatefulWidget {
  const HomeviewerSignup({Key? key}) : super(key: key);

  @override
  State<HomeviewerSignup> createState() => _HomeviewerSignupState();
}

class _HomeviewerSignupState extends State<HomeviewerSignup>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    // _setSMSOtpSetup();
  }

  // _setSMSOtpSetup() async {
  //   SmsAutoFill().listenForCode;
  //   signature = await SmsAutoFill().getAppSignature;
  //   debugPrint('SMS Signature is: ===========================> $signature');
  // }

  openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        // setState(() {
        //   _countryCode = '+${country.phoneCode}';
        // });
        controller.selectCountryCode('+${country.phoneCode}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Signup'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/app_bg.jpg',
                ))),
        child: ListView(
          children: [
            setHeight(10),
            Align(
              child: Image(
                height: 50,
                fit: BoxFit.fill,
                image: AssetImage(
                  APPIMAGES.launchbg,
                ),
              ),
            ),
            setHeight(20),
            setCommonText(
              'Registration'.tr,
              fontSize: 20,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w700,
            ),
            setHeight(20),
            setTextField(
              height: 50,
              controller: controller.signupEmail,
              hint: 'Email'.tr,
              hintColor: AppColors.gray.lightColorHex(),
              fontSize: 14,
              isLabelHidden: true,
              isVisibleBorder: false,
              keyboardType: TextInputType.emailAddress,
              isSecureText: false,
            ),
            setHeight(20),
            GetBuilder<LoginController>(
              builder: (con) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        openCountryPicker();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(con.countryCode),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: setTextField(
                        height: 50,
                        hint: 'Mobile'.tr,
                        controller: controller.signupMobile,
                        hintColor: AppColors.gray.lightColorHex(),
                        fontSize: 14,
                        isLabelHidden: true,
                        isVisibleBorder: false,
                        keyboardType: TextInputType.phone,
                        isSecureText: false,
                      ),
                    )
                  ],
                );
              },
            ),
            setHeight(35),
            createButton(
                text: 'Continue'.tr,
                txtColor: AppColors.white.lightColorHex(),
                fontSize: 14,
                onBtnClick: () {
                  controller.continueToUserCreations();
                }),
            setHeight(20),
            SocialMediaButtons(),
          ],
        ),
      ),
    );
  }
}
