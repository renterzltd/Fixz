import 'package:fixz/hdHelper/exportFile.dart';

class SpecificTImeWidget extends StatefulWidget {
  const SpecificTImeWidget({Key? key}) : super(key: key);

  @override
  State<SpecificTImeWidget> createState() => _SpecificTImeWidgetState();
}

class _SpecificTImeWidgetState extends State<SpecificTImeWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setCommonText(
              'At what time do you need the service provider?'.tr,
              fontSize: 14,
              color: AppColors.black.lightColorHex(),
              fontWeight: FontWeight.w400,
            ),
            setHeight(10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children:
                  List<Widget>.generate(con.specificTimeList.length, (index) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      con.selectFixedTime(index);
                    },
                    child: Card(
                      color: con.specificTimeList[index].isSelect
                          ? AppColors.colorPrimaryDark.lightColorHex()
                          : Colors.white,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                con.specificTimeList[index].icon,
                                color: con.specificTimeList[index].isSelect
                                    ? Colors.white
                                    : AppColors.black.lightColorHex(),
                              ),
                              setCommonText(
                                con.specificTimeList[index].title,
                                fontSize: 14,
                                color: con.specificTimeList[index].isSelect
                                    ? Colors.white
                                    : AppColors.black.lightColorHex(),
                                fontWeight: FontWeight.w400,
                              ),
                              setHeight(10),
                              setCommonText(
                                con.specificTimeList[index].time,
                                fontSize: 14,
                                color: con.specificTimeList[index].isSelect
                                    ? Colors.white
                                    : AppColors.black.lightColorHex(),
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
