import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';

class CommonAlertWithMessage extends StatelessWidget with ButtonMixin {
  final String title;
  final String message;
  final Function(bool)? onTap;
  const CommonAlertWithMessage(
      {super.key, this.onTap, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: 220,
        width: MediaQuery.sizeOf(context).width / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: 30,
              width: 100,
              image: AssetImage(APPIMAGES.renterzLog),
            ),
            setHeight(4),
            setCommonText(
              title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            setHeight(6),
            setCommonText(
              message,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              noOfLine: 2,
            ),
            setHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                createButton(
                  hideGradient: true,
                  height: 40,
                  width: 100,
                  btnColour: AppColors.colorPrimaryDark.lightColorHex(),
                  text: 'YES',
                  txtColor: AppColors.white.lightColorHex(),
                  onBtnClick: () {
                    onTap?.call(true);
                  },
                ),
                setWidth(8),
                createButton(
                  hideGradient: true,
                  height: 40,
                  width: 100,
                  btnColour: AppColors.colorPrimaryDark.lightColorHex(),
                  text: 'NO',
                  txtColor: AppColors.white.lightColorHex(),
                  onBtnClick: () {
                    onTap?.call(false);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
