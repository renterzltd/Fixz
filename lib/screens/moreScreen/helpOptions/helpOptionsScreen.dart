import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/homeWebView/homeWebView.dart';
import 'package:fixz/screens/moreScreen/disputeRequestList/dispute_request_list.dart';
import 'package:fixz/screens/stripeVerification/stripe_verification.dart';

class HelpOptionScreen extends StatefulWidget {
  const HelpOptionScreen({Key? key}) : super(key: key);

  @override
  State<HelpOptionScreen> createState() => _HelpOptionScreenState();
}

class _HelpOptionScreenState extends State<HelpOptionScreen> with AppbarMixin {
  List<MOREOPTION> moreOption = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moreOption = [
      MOREOPTION(
        isSelect: false,
        title: 'Support Centre'.tr,
        iconData: Icons.person,
        isLogout: false,
        // screen: InAppWebViewPage()
        screen: HomeWebViewSceen(
          title: 'Support Centre'.tr,
          webUrl: WebUrls.webSupport,
        ),
      ),
      MOREOPTION(
        isSelect: false,
        title: 'Terms & Conditions'.tr,
        iconData: Icons.person,
        isLogout: false,
        screen: HomeWebViewSceen(
          title: 'Terms & Conditions'.tr,
          webUrl: WebUrls.webTerms,
        ),
      ),
      MOREOPTION(
        isSelect: false,
        title: 'Insurance'.tr,
        iconData: Icons.person,
        isLogout: false,
        screen: HomeWebViewSceen(
          title: 'Insurance'.tr,
          webUrl: WebUrls.webInsurance,
        ),
      ),
      MOREOPTION(
        isSelect: false,
        title: 'Privacy policy'.tr,
        iconData: Icons.person,
        isLogout: false,
        screen: HomeWebViewSceen(
          title: 'Privacy policy'.tr,
          webUrl: WebUrls.webPolicy,
        ),
      ),
      MOREOPTION(
        isSelect: false,
        title: 'Community Guidelines'.tr,
        iconData: Icons.person,
        isLogout: false,
        screen: HomeWebViewSceen(
          title: 'Community Guidelines'.tr,
          webUrl: WebUrls.webCommunity,
        ),
      ),
      MOREOPTION(
        isSelect: false,
        title: 'Dispute Request'.tr,
        iconData: Icons.person,
        isLogout: false,
        screen: const DisputeRequestList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar(
        'Help'.tr,
        bgColor: AppColors.colorPrimaryDark.lightColorHex(),
        textColor: AppColors.white.lightColorHex(),
        backIconColor: Colors.white,
        onBackClick: () {},
      ),
      body: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: moreOption.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (moreOption[index].screen != null) {
                      NavigationService()
                          .setNavigator(moreOption[index].screen!);
                    }
                  },
                  title: setCommonText(
                    moreOption[index].title!,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: moreOption[index].isLogout!
                        ? Colors.transparent
                        : Colors.grey.shade400,
                    size: 16,
                  ),
                  // leading: Icon(
                  //   moreOption[index].iconData,
                  //   color: Colors.grey,
                  //   size: 20,
                  // ),
                );
              })),
    );
  }
}

class MOREOPTION {
  String? title;
  bool? isSelect;
  IconData? iconData;
  bool? isLogout;
  Widget? screen;

  MOREOPTION({
    this.title,
    this.isSelect,
    this.iconData,
    this.isLogout,
    this.screen,
  });
}
