// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'dart:math';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';
import 'helper/global_utils.dart';

import 'helper/network_helper.dart';

class WebviewScreen extends StatefulWidget {
  final Quotations item;
  static const String id = 'webview_screen';

  const WebviewScreen({super.key, required this.item});
  // late final String title;
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> with AppbarMixin {
  var _url = '';
  var random = Random.secure();
  String redirectionurl = '';
  bool _loadWebView = false;
  late WebViewController _con;

  String firstName = '';
  String lastName = '';
  String email = '';
  String deviceId = '';
  String phone = '';

  _getUserData() async {
    firstName = await SharedManager.shared.getUserName() ?? 'No Name';
    lastName = await SharedManager.shared.getUserName() ?? 'No Name';
    email = await SharedManager.shared.getUserEmail() ?? 'no email';
    deviceId = await SharedManager.shared.getDeviceId() ?? '';
    phone = await SharedManager.shared.getUserPhone() ?? '';
  }

  void _cardgetcardtokenapi() async {
    NetWorkHelper netWorkHelper = NetWorkHelper();
    dynamic response = await netWorkHelper.getcardtoken(
        GlobalUtils.storeid,
        GlobalUtils.cardnumber,
        GlobalUtils.cardexpirymonth,
        GlobalUtils.cardexpiryyr,
        GlobalUtils.cardcvv);

    if (response == null) {
      // no data show error message.
    } else {
      if (response.toString().contains('Failure')) {
        // _showLoader = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No data to show"),
        ));
      } else {
        var token = response['CardTokenResponse']['Token'].toString();
        GlobalUtils.token = token;
        debugPrint('YOUR TOKEN IS: *********** $token');
        if (GlobalUtils.token.length > 3 && token.toLowerCase() != 'null') {
          createXMLAfterGetCard();
        } else {
          AlertClass.shared.setSnackbar('Please enter valid card details');
          NavigationService().setPopNavigator();
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
    _cardgetcardtokenapi();
    //_callApi();
  }

  @override
  void dispose() async {
    await EasyLoading.dismiss();
    GlobalUtils.token = '';
    _loadWebView = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar(
        'Make Payment'.tr,
        bgColor: AppColors.white.lightColorHex(),
        elivation: 1.0,
        fontSize: 20,
      ),
      body: _loadWebView
          ? Builder(builder: (BuildContext context) {
              return Container(
                color: Colors.white,
                width: 800, //MediaQuery.of(context).size.width
                height: 1800, //MediaQuery.of(context).size.height
                child: WebView(
                  initialUrl: _url, //ooooo
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _con = webViewController;
                  },
                  onProgress: (int progress) async {
                    if (_loadWebView) {
                      await EasyLoading.show(status: 'Loading...');
                    }
                    debugPrint('HD ************** IN PROGRESS **************');
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.contains('telr.com')) {}
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    debugPrint('HD ************** PAGE STARTED **************');
                  },
                  onPageFinished: (String url) async {
                    await EasyLoading.dismiss();
                    if (url.contains('telr.com')) {
                      debugPrint(
                          'HD ************** PAGE FINISHED **************');
                    }
                  },
                  gestureNavigationEnabled: true,
                ),
              );
            })
          : const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  void createXMLAfterGetCard() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(GlobalUtils.storeid);
      });
      builder.element('key', nest: () {
        builder.text(GlobalUtils.authkey);
      });
      builder.element('framed', nest: () {
        builder.text(GlobalUtils.framed);
      });

      builder.element('device', nest: () {
        builder.element('type', nest: () {
          builder.text(GlobalUtils.devicetype);
        });
        builder.element('id', nest: () async {
          builder.text(deviceId);
        });
      });

      // app
      builder.element('app', nest: () {
        builder.element('name', nest: () {
          builder.text(widget.item.name ?? '');
        });
        builder.element('version', nest: () {
          builder.text(GlobalUtils.version);
        });
        builder.element('user', nest: () {
          builder.text(GlobalUtils.appuser);
        });
        builder.element('id', nest: () {
          builder.text(GlobalUtils.appid);
        });
      });

      //tran
      builder.element('tran', nest: () {
        builder.element('test', nest: () {
          builder.text(GlobalUtils.testmode);
        });
        builder.element('type', nest: () {
          builder.text('paypage');
        });
        builder.element('class', nest: () {
          builder.text('sale');
        });
        builder.element('cartid', nest: () {
          builder.text(100000000 + random.nextInt(999999999));
        });
        builder.element('description', nest: () {
          builder.text('Test for Mobile API order');
        });
        builder.element('currency', nest: () {
          builder.text('aed');
        });
        builder.element('amount', nest: () {
          builder.text('${widget.item.cost}');
        });
        builder.element('language', nest: () {
          builder.text('en');
        });
        // builder.element('firstref', nest: (){ // parameter for proceed with refid
        //   builder.text(GlobalUtils.firstref);
        // });
        // builder.element('ref', nest: (){ // parameter for proceed with transaction reference
        //   builder.text('null');
        // });
      });
//new changes to add savecard option
      // builder.element('card', nest: () {
      //   builder.element('savecard', nest: () {
      //     builder.text(GlobalUtils.keysaved);
      //   });
      // });
      //---------------------------------
      //billing
      builder.element('billing', nest: () {
        // name
        builder.element('name', nest: () {
          builder.element('title', nest: () {
            builder.text('');
          });
          builder.element('first', nest: () {
            builder.text(firstName);
          });
          builder.element('last', nest: () {
            builder.text(lastName);
          });
        });
        // address
        builder.element('address', nest: () {
          builder.element('line1', nest: () {
            builder.text(GlobalUtils.addressline1);
          });
          builder.element('city', nest: () {
            builder.text(GlobalUtils.city);
          });
          builder.element('region', nest: () {
            builder.text('AE');
          });
          builder.element('country', nest: () {
            builder.text(GlobalUtils.country);
          });
        });

        builder.element('phone', nest: () {
          builder.text(phone);
        });
        builder.element('email', nest: () {
          builder.text(email);
        });
      });

      builder.element('custref', nest: () {
        builder.text(GlobalUtils.custref);
      });
      builder.element('paymethod', nest: () {
        builder.element('type', nest: () {
          builder.text(GlobalUtils.paymenttype);
        });
        builder.element('cardtoken', nest: () {
          builder.text(GlobalUtils.token);
        });
      });
    });

    final bookshelfXml = builder.buildDocument();
    debugPrint('Final payment XML Format------------------->274 $bookshelfXml');
    pay(bookshelfXml);
  }

  void pay(XmlDocument xml) async {
    NetWorkHelper netWorkHelper = NetWorkHelper();

    final response = await netWorkHelper.pay(xml);

    if (response == 'failed' || response == null) {
    } else {
      final doc = XmlDocument.parse(response);
      final url = doc.findAllElements('start').map((node) => node.text);
      final code = doc.findAllElements('code').map((node) => node.text);

      _url = url.toString();
      String _code = code.toString();
      if (_url.length > 2) {
        _url = _url.replaceAll('(', '');
        _url = _url.replaceAll(')', '');
        _code = _code.replaceAll('(', '');
        _code = _code.replaceAll(')', '');
        GlobalUtils.code = _code;
      }

      final message = doc.findAllElements('message').map((node) => node.text);
      setState(() {
        // if
        _loadWebView = true;
      });

      createResponseXMLL(); //
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
      }
    }
  }

  void createResponseXMLL() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(GlobalUtils.storeid);
      });
      builder.element('key', nest: () {
        builder.text(GlobalUtils.authkey);
      });

      builder.element('complete', nest: () {
        builder.text(GlobalUtils.code);
      });
    });

    final bookshelfXml = builder.buildDocument();

    //return bookshelfXml.toString();
    getTransactionstatus(bookshelfXml);
  }

  void getTransactionstatus(XmlDocument bookshelfXml) async {
    NetWorkHelper netWorkHelper = NetWorkHelper();

    final response = await netWorkHelper.getTransactionstatus(bookshelfXml);
    if (response == 'failed' || response == null) {
      //add the navigation code here
    } else {
      final doc = XmlDocument.parse(response);

      final trnsstatus =
          doc.findAllElements('message').map((node) => node.text);
      debugPrint('Transaction Status is:${trnsstatus.toString()}');
      if (trnsstatus.toString() == '(Pending)') {
        getTransactionstatus(bookshelfXml);
      } else {
        debugPrint('Transaction Status is: $trnsstatus');
        debugPrint('Transaction DOCS is: $doc');
        final trnsReference =
            doc.findAllElements('tranref').map((node) => node.text);
        final transStatus =
            doc.findAllElements('status').map((node) => node.text);
        debugPrint('Transaction REFERENCE is: $trnsReference');
        debugPrint('Transaction STATUS is: $transStatus');
        final data = {
          'refID': '$trnsReference',
          'status': '$transStatus',
        };
        Navigator.of(context).pop(data);
        EasyLoading.dismiss();
      }
    }
  }
}
