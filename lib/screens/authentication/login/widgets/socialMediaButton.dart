// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:fixz/hdHelper/exportFile.dart';

// class SocialMediaButtons extends StatefulWidget {
//   const SocialMediaButtons({Key? key}) : super(key: key);

//   @override
//   State<SocialMediaButtons> createState() => _SocialMediaButtonsState();
// }

// class _SocialMediaButtonsState extends State<SocialMediaButtons> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LoginController>(
//       builder: (con) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             setHeight(25),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                   height: 2,
//                   color: AppColors.colorPrimary.lightColorHex(),
//                 )),
//                 setWidth(10),
//                 setCommonText(
//                   'Or continue with',
//                   color: AppColors.colorPrimary.lightColorHex(),
//                   fontSize: 14,
//                 ),
//                 setWidth(10),
//                 Expanded(
//                     child: Container(
//                   height: 2,
//                   color: AppColors.colorPrimary.lightColorHex(),
//                 )),
//               ],
//             ),
//             setHeight(25),
//             // Row(
//             //   children: [
//             //     Expanded(
//             //       child: InkWell(
//             //         onTap: () {},
//             //         child: Container(
//             //             height: 40,
//             //             decoration: BoxDecoration(
//             //                 color: AppColors.facebookBlue.lightColorHex(),
//             //                 borderRadius: BorderRadius.circular(20)),
//             //             alignment: Alignment.center,
//             //             child: Row(
//             //               children: [
//             //                 setWidth(15),
//             //                 // ignore: prefer_const_constructors
//             //                 Image(
//             //                   image: AssetImage('assets/images/facebook.png'),
//             //                   height: 20,
//             //                   width: 20,
//             //                 ),
//             //                 setWidth(5),
//             //                 Expanded(
//             //                   child: setCommonText(
//             //                     'Facebook',
//             //                     color: AppColors.white.lightColorHex(),
//             //                     textAlignment: TextAlign.center,
//             //                   ),
//             //                 ),
//             //                 setWidth(35),
//             //               ],
//             //             )),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             setHeight(20),
//             Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () async {
//                       con.onGoogleSignIn(context);
//                     },
//                     child: Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: AppColors.white.lightColorHex(),
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 2.0,
//                                 spreadRadius: 3.0,
//                                 offset: Offset(0, 0),
//                                 color: Colors.grey.shade300,
//                               ),
//                             ]),
//                         alignment: Alignment.center,
//                         child: Row(
//                           children: [
//                             setWidth(15),
//                             // ignore: prefer_const_constructors
//                             Image(
//                               image: AssetImage('assets/images/google.png'),
//                               height: 20,
//                               width: 20,
//                             ),
//                             setWidth(5),
//                             Expanded(
//                               child: setCommonText(
//                                 'Google',
//                                 color: AppColors.black.lightColorHex(),
//                                 textAlignment: TextAlign.center,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             setWidth(35),
//                           ],
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//             setHeight(20),
//             RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   text: 'By signing up, I agree to Fixz\'s ',
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   children: [
//                     TextSpan(
//                         text: 'Terms & Conditions',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         )),
//                     TextSpan(
//                         text: ' and ',
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         )),
//                     TextSpan(
//                         text: 'Privacy Policy',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         )),
//                   ],
//                 ))
//           ],
//         );
//       },
//     );
//   }
// }
