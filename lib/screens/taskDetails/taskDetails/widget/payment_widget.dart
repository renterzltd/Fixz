import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentWidget extends StatefulWidget {
  // final Function(TokenData tokenData)? getTokenData;
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> with ButtonMixin {
  bool isLoading = false;
  // CardFieldInputDetails? _card;
  // _generateTokenData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final tokenData = await Stripe.instance.createToken(
  //     CreateTokenParams.card(
  //       params: CardTokenParams(
  //         type: TokenType.Card,
  //         currency: !SharedManager.shared.isDubaiVersion ? 'USD' : 'AED',
  //       ),
  //     ),
  //   );
  //   widget.getTokenData?.call(tokenData);
  //   NavigationService().setPopNavigator();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          setHeight(20),
          Text(
            'Hire Contractor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimaryDark.lightColorHex(),
            ),
          ),
          setHeight(20),
          const Divider(color: Colors.black38),
          setHeight(20),
          // CardField(
          //   autofocus: true,
          //   onCardChanged: (card) {
          //     _card = card;
          //   },
          // ),
          setHeight(50),
          InkWell(
            onTap: () {
              // debugPrint('_card?.complete status :${_card?.complete}');
              // _card?.complete == true
              //     ? _generateTokenData()
              //     : AlertClass.shared.shoAlertWithSingleButton(
              //         'Please add payment details'.tr,
              //       );
            },
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.colorPrimaryDark.lightColorHex(),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(
                        color: AppColors.white.lightColorHex(),
                      ),
                    )
                  : setCommonText(
                      'Make Payemt',
                      color: AppColors.white.lightColorHex(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
