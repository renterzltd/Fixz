// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/gestures.dart';

class SocialMediaButtons extends StatefulWidget {
  const SocialMediaButtons({Key? key}) : super(key: key);

  @override
  State<SocialMediaButtons> createState() => _SocialMediaButtonsState();
}

class _SocialMediaButtonsState extends State<SocialMediaButtons> {
  final controller = Get.find<LoginController>();

  _setLoginWithApple() {
    return Column(
      children: [
        setHeight(15),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  controller.loginWithApple();
                },
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.black.lightColorHex(),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            spreadRadius: 3.0,
                            offset: Offset(0, 0),
                            color: Colors.grey.shade300,
                          ),
                        ]),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        setWidth(15),
                        // ignore: prefer_const_constructors
                        Image(
                          image: AssetImage('assets/images/apple.png'),
                          height: 20,
                          width: 20,
                        ),
                        setWidth(5),
                        Expanded(
                          child: setCommonText(
                            'Login with Apple',
                            color: AppColors.white.lightColorHex(),
                            textAlignment: TextAlign.center,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        setWidth(35),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setHeight(25),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 2,
                  color: AppColors.colorPrimary.lightColorHex(),
                )),
                setWidth(10),
                setCommonText(
                  'Or continue with'.tr,
                  color: AppColors.colorPrimary.lightColorHex(),
                  fontSize: 14,
                ),
                setWidth(10),
                Expanded(
                    child: Container(
                  height: 2,
                  color: AppColors.colorPrimary.lightColorHex(),
                )),
              ],
            ),
            setHeight(25),
            // Row(
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         onTap: () {},
            //         child: Container(
            //             height: 40,
            //             decoration: BoxDecoration(
            //                 color: AppColors.facebookBlue.lightColorHex(),
            //                 borderRadius: BorderRadius.circular(20)),
            //             alignment: Alignment.center,
            //             child: Row(
            //               children: [
            //                 setWidth(15),
            //                 // ignore: prefer_const_constructors
            //                 Image(
            //                   image: AssetImage('assets/images/facebook.png'),
            //                   height: 20,
            //                   width: 20,
            //                 ),
            //                 setWidth(5),
            //                 Expanded(
            //                   child: setCommonText(
            //                     'Facebook',
            //                     color: AppColors.white.lightColorHex(),
            //                     textAlignment: TextAlign.center,
            //                   ),
            //                 ),
            //                 setWidth(35),
            //               ],
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
            setHeight(20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      con.onGoogleSignIn(context);
                    },
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white.lightColorHex(),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2.0,
                                spreadRadius: 3.0,
                                offset: Offset(0, 0),
                                color: Colors.grey.shade300,
                              ),
                            ]),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            setWidth(15),
                            // ignore: prefer_const_constructors
                            Image(
                              image: AssetImage('assets/images/google.png'),
                              height: 20,
                              width: 20,
                            ),
                            setWidth(5),
                            Expanded(
                              child: setCommonText(
                                'Google'.tr,
                                color: AppColors.black.lightColorHex(),
                                textAlignment: TextAlign.center,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            setWidth(35),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            (Platform.isIOS) ? _setLoginWithApple() : setHeight(0),
            setHeight(20),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By signing up, I agree to Fixz'.tr,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                        text: 'Terms & Conditions'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService().setNavigator(HomeWebViewSceen(
                              title: 'Terms & Conditions'.tr,
                              webUrl: WebUrls.webTerms,
                            ));
                          },
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    TextSpan(
                        text: " ${"and".tr} ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    TextSpan(
                        text: 'Privacy Policy'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService().setNavigator(HomeWebViewSceen(
                              title: 'Privacy Policy'.tr,
                              webUrl: WebUrls.webPolicy,
                            ));
                          },
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ))
          ],
        );
      },
    );
  }
}
