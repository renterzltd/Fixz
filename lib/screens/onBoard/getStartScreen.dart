// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/onBoard/onboardScreen.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> with ButtonMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            setHeight(50),
            Image(
              height: 249,
              width: 250,
              image: AssetImage(
                APPIMAGES.getStart,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: InkWell(
                onTap: () {
                  NavigationService().setNavigator(
                    OnBoardScreen(),
                  );
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimaryDark.lightColorHex(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: setCommonText('Get Start'.tr, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
