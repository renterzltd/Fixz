// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// class InAppWebViewPage extends StatefulWidget {
//   @override
//   _InAppWebViewPageState createState() => new _InAppWebViewPageState();
// }

// class _InAppWebViewPageState extends State<InAppWebViewPage> {
//   InAppWebViewController? _webViewController;

//   _getPermission() async {
//     await Permission.camera.request();
//     await Permission.microphone.request();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getPermission();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("InAppWebView")),
//         body: Container(
//             child: Column(children: <Widget>[
//           Expanded(
//             child: Container(
//               child: InAppWebView(
//                   initialUrlRequest: URLRequest(
//                       url: Uri.parse('https://renterz.com/stripe_webview/2')),
//                   initialOptions: InAppWebViewGroupOptions(
//                     crossPlatform: InAppWebViewOptions(
//                       mediaPlaybackRequiresUserGesture: false,
//                     ),
//                   ),
//                   onWebViewCreated: (InAppWebViewController controller) {
//                     _webViewController = controller;
//                     _webViewController?.addJavaScriptHandler(
//                         handlerName: 'myCustomEvent',
//                         callback: (message) {
//                           log("Receive Java Script message ------------------>$message");
//                         });
//                   },
//                   onConsoleMessage: (InAppWebViewController controller,
//                       ConsoleMessage consoleMessage) {
//                     log("console message: ${consoleMessage.message}");
//                   },
//                   androidOnPermissionRequest:
//                       (InAppWebViewController controller, String origin,
//                           List<String> resources) async {
//                     return PermissionRequestResponse(
//                         resources: resources,
//                         action: PermissionRequestResponseAction.GRANT);
//                   }),
//             ),
//           ),
//         ])));
//   }
// }
