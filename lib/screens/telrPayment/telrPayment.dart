// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'WebViewScreen.dart';
import 'helper/global_utils.dart';
import 'helper/network_helper.dart';
import 'widgets/payment_status_view.dart';
// import 'package:pay/pay.dart';

class TelrPayment extends StatefulWidget {
  final Quotations item;
  const TelrPayment({super.key, required this.item});

  @override
  State<StatefulWidget> createState() {
    return TelrPaymentState();
  }
}

// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '99.99',
//     status: PaymentItemStatus.final_price,
//   )
// ];

class TelrPaymentState extends State<TelrPayment> with AppbarMixin {
  static String keysaved = '0';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String store = '';
  String keyy = '';
  // bool _showLoader = true;
  // List<dynamic> _list = <dynamic>[];
  // List<TextEditingController> _textEditController = <TextEditingController>[];
  // List<bool> _checkBoxValue = <bool>[];
  // List<FocusNode> _focusNodes = <FocusNode>[];
  // bool _saveCard = false;
  String svdCvv = '';

  @override
  void initState() {
    // getPref();
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onValidate() {
      // _

      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);

      // if (formKey.currentState!.validate()) {
      //   launchURL();
      // } else {}
    }

    return Scaffold(
      appBar: setAppbar(
        'Make Payment'.tr,
        bgColor: AppColors.white.lightColorHex(),
        elivation: 1.0,
        onBackClick: () {},
      ),
      body: Column(
        children: [
          CreditCardWidget(
            glassmorphismConfig:
                useGlassMorphism ? Glassmorphism.defaultConfig() : null,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            bankName: '',
            frontCardBorder: !useGlassMorphism
                ? Border.all(color: AppColors.colorPrimaryDark.lightColorHex())
                : null,
            backCardBorder: !useGlassMorphism
                ? Border.all(color: AppColors.colorPrimaryDark.lightColorHex())
                : null,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            cardBgColor: AppColors.colorPrimaryDark.lightColorHex(),
            backgroundImage: useBackgroundImage ? 'assets/images/bg.png' : null,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.mastercard,
                cardImage: Image.asset(
                  'assets/images/mastercard.png',
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    textColor: AppColors.colorPrimaryDark.lightColorHex(),
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: const TextStyle(color: Color(0xff00A887)),
                      labelStyle: TextStyle(
                          color: AppColors.colorPrimaryDark.lightColorHex()),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xff00A887)),
                      labelStyle: TextStyle(
                          color: AppColors.colorPrimaryDark.lightColorHex()),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText:
                          'Expired Date', // field to adjust the height cccccccccccc
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xff00A887)),
                      labelStyle: TextStyle(
                          color: AppColors.colorPrimaryDark.lightColorHex()),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xff00A887)),
                      labelStyle: TextStyle(
                          color: AppColors.colorPrimaryDark.lightColorHex()),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (cardNumber == '') {
                        AlertClass.shared
                            .setSnackbar('Please enter card number');
                        return;
                      } else if (expiryDate == '') {
                        AlertClass.shared
                            .setSnackbar('Expiry date should not be empty');
                        return;
                      } else if (cvvCode == '') {
                        AlertClass.shared.setSnackbar('Please enter CVV');
                        return;
                      } else if (cardHolderName == '') {
                        AlertClass.shared
                            .setSnackbar('Please enter card holder name');
                        return;
                      }
                      GlobalUtils.cardname = cardHolderName;
                      GlobalUtils.cardnumber = (cardNumber.replaceAll(' ', ''));
                      String str = expiryDate;
                      List<String> strarray = str.split('/');
                      GlobalUtils.cardexpirymonth = strarray[0];
                      GlobalUtils.cardexpiryyr = strarray[1];
                      GlobalUtils.cardcvv = cvvCode;

                      final res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebviewScreen(
                            item: widget.item,
                          ),
                        ),
                      );
                      if (res != null) {
                        log('Log Response:$res');
                        var refId = res['refID'];
                        var status = res['status'];
                        refId = refId.replaceAll('(', '');
                        refId = refId.replaceAll(')', '');

                        status = status.replaceAll('(', '');
                        status = status.replaceAll(')', '');

                        log('Final Reference ID:$refId');
                        log('Final Payment Status:$status');
                        if (status == 'A') {
                          //Make Payement api call
                          openBottomsheetForMakePayment(true);
                          Timer(const Duration(seconds: 3), () {
                            NavigationService().setPopNavigator();
                            Navigator.of(context).pop(refId);
                          });
                        } else {
                          //Payemtn Failed view open
                          openBottomsheetForMakePayment(false);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimaryDark.lightColorHex(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        'MAKE PAYMENT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openBottomsheetForMakePayment(bool status) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: PaymentStatusView(isPaymentSuccess: status),
          );
        });
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  // void launchURL() {
  //   //Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
  // }

  // void getdelcardList() async {
  //   NetWorkHelper netWorkHelper = NetWorkHelper();
  //   dynamic response = await netWorkHelper.getdeletecardlist(
  //       store, keyy, GlobalUtils.transref);

  //   if (response == null) {
  //     // no data show error message.
  //   } else {
  //     if (response.toString().contains('Success')) {
  //       // _showLoader = false;
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Card deleted successfully"),
  //       ));
  //     } else {}
  //   }
  // }

// void _launchURL(String url, String code) async {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (BuildContext context) => WebViewScreen(
//             url : url,
//             code: code,
//           ))).then((value) => getCards());
// }
}
