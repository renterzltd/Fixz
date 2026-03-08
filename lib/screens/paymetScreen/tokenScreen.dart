// // ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously

// // import 'package:fixz/hdHelper/exportFile.dart';
// import 'dart:developer';

// import 'package:fixz/hdHelper/commonWidget.dart';
// import 'package:fixz/mixers/appbarMixier.dart';
// import 'package:fixz/mixers/buttonMixin.dart';
// import 'package:fixz/resources/colors.dart';
// import 'package:fixz/util/alert.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';

// class LegacyTokenCardScreen extends StatefulWidget {
//   @override
//   _LegacyTokenCardScreenState createState() => _LegacyTokenCardScreenState();
// }

// class _LegacyTokenCardScreenState extends State<LegacyTokenCardScreen>
//     with ButtonMixin, AppbarMixin {
//   CardFieldInputDetails? _card;

//   TokenData? tokenData;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: setAppbar('Make Payment'.tr,
//           textColor: AppColors.white.lightColorHex(),
//           backIconColor: AppColors.white.lightColorHex()),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: Colors.grey.shade400,
//                     )),
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     setHeight(30),
//                     CardField(
//                       autofocus: true,
//                       onCardChanged: (card) {
//                         setState(() {
//                           _card = card;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     createButton(
//                         width: MediaQuery.of(context).size.width - 40,
//                         text: 'Make Payment'.tr,
//                         txtColor: AppColors.white.lightColorHex(),
//                         onBtnClick: () {
//                           debugPrint('_card?.complete:${_card?.complete}');
//                           _card?.complete == true
//                               ? _handleCreateTokenPress()
//                               : AlertClass.shared.shoAlertWindow(
//                                   'Please fill all data'.tr,
//                                 );
//                         }),
//                     setHeight(30),
//                   ],
//                 ),
//               ),
//             ),

//             // TextButton(
//             //   onPressed: _card?.complete == true ? _handleCreateTokenPress : null,
//             //   child: Text('Create token'),
//             // ),
//             SizedBox(height: 20),
//             // if (tokenData != null)
//             //   ResponseCard(
//             //     response: tokenData!.toJson().toPrettyString(),
//             //   )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _handleCreateTokenPress() async {
//     if (_card == null) {
//       return;
//     }

//     try {
//       // 2. Create payment method
//       final address1 = Address(
//         city: 'Houston',
//         country: 'US',
//         line1: '1459  Circle Drive',
//         line2: '',
//         state: 'Texas',
//         postalCode: '77063',
//       ); // mocked data for tests
//       debugPrint('Token:$address1');
//       // 2. Create payment method
//       final tokenData = await Stripe.instance.createToken(
//         CreateTokenParams.card(
//           params: CardTokenParams(
//             type: TokenType.Card,
//             address: address1,
//             currency: 'USD',
//           ),
//         ),
//       );
//       debugPrint('Token:$tokenData');
//       setState(() {
//         this.tokenData = tokenData;
//       });
//       debugPrint('Token:$tokenData');
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(
//       //         'Success: The token was created successfully!\n$tokenData')));
//       Navigator.of(context).pop(tokenData.id);
//       return;
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//       rethrow;
//     }
//   }
// }
