// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Forgot Password'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: Stack(
        children: [
          // Image(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     image: AssetImage(
          //       'assets/images/app_bg.jpg',
          //     )),
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
                    ))),
            // color: AppColors.white.lightColorHex(),
            child: ListView(
              children: [
                setCommonText(
                  'Forgot Password?',
                  fontSize: 30,
                  color: AppColors.black.lightColorHex(),
                  fontWeight: FontWeight.w700,
                ),
                setHeight(5),
                setCommonText(
                    'Enter your register email address here, we will send passowrd reset link.'
                        .tr,
                    fontSize: 14,
                    color: AppColors.gray.lightColorHex(),
                    fontWeight: FontWeight.w500,
                    noOfLine: 3),
                setHeight(20),
                setTextField(
                  height: 40,
                  hint: 'Email'.tr,
                  hintColor: AppColors.gray.lightColorHex(),
                  fontSize: 14,
                  isLabelHidden: true,
                  isVisibleBorder: false,
                  keyboardType: TextInputType.emailAddress,
                  isSecureText: false,
                ),
                setHeight(40),
                createButton(
                    text: 'Submit'.tr,
                    txtColor: AppColors.white.lightColorHex(),
                    fontSize: 14,
                    onBtnClick: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
