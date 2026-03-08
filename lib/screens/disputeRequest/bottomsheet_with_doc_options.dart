import 'package:fixz/hdHelper/exportFile.dart';

class BottomSheetWithDocOptions extends StatelessWidget {
  final Function(bool)? onSelectOption;
  const BottomSheetWithDocOptions({
    super.key,
    this.onSelectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white.lightColorHex(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          setHeight(10),
          setCommonText(
            'Select Image',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          setHeight(10),
          const Divider(),
          _commonListTileWithTwoIcons(
            title: 'Select From Gallery',
            icon: Icons.file_present_rounded,
            onTap: () {
              onSelectOption?.call(true);
            },
          ),
          const Divider(),
          _commonListTileWithTwoIcons(
            title: 'Capture Image',
            icon: Icons.camera_alt,
            onTap: () {
              onSelectOption?.call(false);
            },
          ),
        ],
      ),
    );
  }

  _commonListTileWithTwoIcons({
    required String title,
    required IconData icon,
    Function? onTap,
  }) {
    return ListTile(
      onTap: () {
        onTap?.call();
      },
      leading: Icon(
        icon,
        color: AppColors.gray_mid.lightColorHex(),
      ),
      title: setCommonText(
        title,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.gray_mid.lightColorHex(),
        size: 18,
      ),
    );
  }
}
