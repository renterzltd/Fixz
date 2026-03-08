// import 'dart:developer';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class HomeWebViewSceen extends StatefulWidget {
  final String webUrl;
  final String title;
  const HomeWebViewSceen({Key? key, this.webUrl = "", this.title = ""})
      : super(key: key);

  @override
  State<HomeWebViewSceen> createState() => _HomeWebViewSceenState();
}

class _HomeWebViewSceenState extends State<HomeWebViewSceen> with AppbarMixin {
  bool isLoading = true;

  // WebViewController controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..addJavaScriptChannel('message', onMessageReceived: (message) {
  //     debugPrint(
  //         '===========================================================>Message');
  //   })
  //   ..setBackgroundColor(const Color(0x00000000))
  //   ..setNavigationDelegate(
  //     NavigationDelegate(
  //       onProgress: (int progress) {},
  //       onPageStarted: (String url) {},
  //       onPageFinished: (String url) {},
  //       onWebResourceError: (WebResourceError error) {},
  //     ),
  //   );

  _getPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  _hideLoader() {
    isLoading = false;
  }

  @override
  void initState() {
    _getPermission();
    super.initState();
    // controller.loadRequest(Uri.parse(widget.webUrl));

    // controller.loadRequest(Uri.parse('https://renterz.com/stripe_webview/2'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setAppbar(
          widget.title,
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: Colors.white,
          onBackClick: () {},
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.webUrl),
              ),
              onLoadStop: (value, url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            (isLoading)
                ? const Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
