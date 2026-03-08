import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/selectLanguages/languageController.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> with AppbarMixin {
  final languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar(
        'Change Language'.tr,
        textColor: Colors.white,
        backIconColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setCommonText('Choose Language'.tr,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.Black.lightColorHex(),
                textAlignment: TextAlign.start),
            setHeight(25),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // color: kRed,
              child: GetBuilder<LanguageController>(
                builder: (controller) {
                  return ListView.separated(
                    itemCount: controller.languageList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.updateValue(index);
                        },
                        child: Column(
                          children: [
                            setHeight(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(controller
                                              .languageList[index].imgFlag))),
                                ),
                                setWidth(15),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      setCommonText(
                                          '${controller.languageList[index].title}',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      (controller.languageList[index].isSelect)
                                          ? Icon(
                                              Icons.check,
                                              color: AppColors.colorPrimaryDark
                                                  .lightColorHex(),
                                            )
                                          : setHeight(1)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            setHeight(5)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                  );
                },
              ),
            )),
            GetBuilder<LanguageController>(
              builder: (controller) {
                return InkWell(
                  onTap: () async {
                    await EasyLoading.show(status: 'Loading...'.tr);
                    languageController.saveLanguage();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: (controller.languageFilterList.isNotEmpty)
                            ? AppColors.colorPrimaryDark.lightColorHex()
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: setCommonText('SAVE'.tr,
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
