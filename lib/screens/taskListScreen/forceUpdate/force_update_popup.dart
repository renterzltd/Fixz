import 'dart:io';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdatePopup extends StatelessWidget with ButtonMixin {
  final String webUrl;
  const ForceUpdatePopup({super.key, required this.webUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(
            20,
          ),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'New Update is available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'The current version of app is no longer supported. Please update now.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: createButton(
              hideGradient: true,
              btnColour: AppColors.colorPrimaryDark.lightColorHex(),
              height: 50,
              text: 'UPDATE NOW',
              txtColor: Colors.white,
              weightFont: FontWeight.w600,
              onBtnClick: () async {
                //Kill App First
                //Move to store respectively
                if (Platform.isAndroid || Platform.isIOS) {
                  final appId =
                      Platform.isAndroid ? 'com.app.fixz' : '1631815544';
                  final url = Uri.parse(
                    webUrl != ''
                        ? webUrl
                        : Platform.isAndroid
                            ? "market://details?id=$appId"
                            : "https://apps.apple.com/app/id$appId",
                  );
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
                exit(0);
              },
            ),
          )
        ],
      ),
    );
  }
}
