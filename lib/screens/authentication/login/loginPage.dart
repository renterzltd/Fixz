// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/authentication/widget/socialMediaWidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:sms_autofill/sms_autofill.dart';

class HomeviewerLogin extends StatefulWidget {
  const HomeviewerLogin({Key? key}) : super(key: key);

  @override
  State<HomeviewerLogin> createState() => _HomeviewerLoginState();
}

class _HomeviewerLoginState extends State<HomeviewerLogin>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  //Mark: Variables

  final controller = Get.put(LoginController());
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    super.initState();
    controller.otpController = TextEditingController();
    controller.numberController = TextEditingController();
    _setSMSOtpSetup();
  }

  @override
  void dispose() {
    controller.clearOTPController();
    super.dispose();
  }

  _setSMSOtpSetup() async {
    await SmsAutoFill().listenForCode;
    signature = await SmsAutoFill().getAppSignature;
    debugPrint('SMS Signature is: ===========================> $signature');
  }

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

  //Mark Custom method
  _setLoginView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          'Login'.tr,
          fontSize: 20,
          color: AppColors.black.lightColorHex(),
          fontWeight: FontWeight.w700,
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
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
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
                    controller: controller.numberController,
                    hint: 'Phone'.tr,
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
            text: 'Login'.tr,
            txtColor: AppColors.white.lightColorHex(),
            fontSize: 14,
            onBtnClick: () {
              controller.makeLogin();
            }),
        setHeight(20),
        SocialMediaButtons(),
      ],
    );
  }

  _setVerifyOtpScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          'Verify OTP'.tr,
          fontSize: 20,
          color: AppColors.black.lightColorHex(),
          fontWeight: FontWeight.w700,
        ),
        setHeight(20),
        GetBuilder<LoginController>(
          builder: (con) {
            return PinFieldAutoFill(
              controller: con.otpController,
              codeLength: 4,
              decoration: UnderlineDecoration(
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.5)),
              ),
              currentCode: codeSMS,
              onCodeSubmitted: (code) {
                debugPrint('Code is ===>');
              },
              onCodeChanged: (code) {
                if (code!.length == 4) {
                  debugPrint('Final SMS Code is:-');
                  codeSMS = code;
                  // controller.text = code;
                  // model.code = code;
                  // debugPrint('Controller code"${controller.text}');
                  // setState(() {});
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            );
            // return Container(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: PinCodeTextField(
            //     length: 4,
            //     obscureText: false,
            //     animationType: AnimationType.fade,
            //     pinTheme: PinTheme(
            //       shape: PinCodeFieldShape.box,
            //       borderRadius: BorderRadius.circular(10),
            //       fieldHeight: 50,
            //       fieldWidth: 60,
            //       activeFillColor: AppColors.LightGrey.lightColorHex(),
            //       inactiveFillColor: AppColors.LightGrey.lightColorHex(),
            //       inactiveColor: AppColors.LightGrey.lightColorHex(),
            //       // activeColor: AppColors.lightGrey,
            //       // selectedFillColor: AppColors.lightGrey,
            //       selectedColor: Colors.black,
            //     ),
            //     cursorColor: Colors.black,
            //     animationDuration: const Duration(milliseconds: 300),
            //     backgroundColor: Colors.transparent,
            //     enableActiveFill: true,
            //     errorAnimationController: errorController,
            //     controller: con.otpController,
            //     keyboardType: TextInputType.number,
            //     onCompleted: (v) {
            //       // UtilityHelper.showLog("Completed $v");
            //       // controller.OTP = v;
            //       // controller.update();
            //       // controller.verifyOTP(mobileNo);
            //     },
            //     onChanged: (value) {},
            //     beforeTextPaste: (text) {
            //       // UtilityHelper.showLog("Allowing to paste $text");
            //       //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //       //but you can show anything you want here, like your pop up saying wrong paste format or etc
            //       return true;
            //     },
            //     appContext: Get.context!,
            //   ),
            // );
          },
        ),
        setHeight(35),
        createButton(
            text: 'Verify'.tr,
            txtColor: AppColors.white.lightColorHex(),
            fontSize: 14,
            onBtnClick: () {
              controller.verifyOTP();
            }),
        setHeight(20),
        InkWell(
          onTap: () async {
            // await _setSMSOtpSetup();
            controller.resendOTP();
          },
          child: setCommonText(
            'Resend OTP?'.tr,
            fontSize: 15,
            color: AppColors.gray.lightColorHex(),
            fontWeight: FontWeight.w500,
            textAlignment: TextAlign.end,
          ),
        ),
        SocialMediaButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Login'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0, onBackClick: () {
        // controller.clearAll();
        // NavigationService().setPopNavigator();
      }),
      body: GetBuilder<LoginController>(
        builder: (con) {
          return SingleChildScrollView(
            child: Column(
              children: [
                setHeight(30),
                Image(
                  height: 50,
                  fit: BoxFit.fill,
                  image: AssetImage(
                    APPIMAGES.launchbg,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/app_bg.jpg',
                      ),
                    ),
                  ),
                  child: con.isLogin ? _setVerifyOtpScreen() : _setLoginView(),
                  // child: con.isLogin ? Container() : _setLoginView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
