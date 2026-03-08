// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:fixz/hdHelper/exportFile.dart';

class MustHaveScreen extends StatefulWidget {
  const MustHaveScreen({Key? key}) : super(key: key);

  @override
  State<MustHaveScreen> createState() => _MustHaveScreenState();
}

class _MustHaveScreenState extends State<MustHaveScreen>
    with AppbarMixin, ButtonMixin, TextFieldMixin {
  //MARK: Variables
  //
  final controller = Get.find<AddTaskController>();

  setcommonRowWidget(String title, {bool isHideDot = false}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isHideDot
              ? setWidth(0)
              : Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.gray.lightColorHex(),
                  ),
                ),
          isHideDot ? setWidth(0) : setWidth(5),
          Expanded(
            child: setCommonText(
              title,
              fontSize: 14,
              color: AppColors.gray.lightColorHex(),
              fontWeight: FontWeight.w500,
              noOfLine: 3,
            ),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Must Have',
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: GetBuilder<AddTaskController>(
        builder: (con) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                setcommonRowWidget(
                    'Add up to 3 things the tasker needs to have or do to make an offer - e.g.'
                        .tr,
                    isHideDot: true),
                setHeight(15),
                setcommonRowWidget(
                  'Must have available on sunday morning'.tr,
                ),
                setHeight(5),
                setcommonRowWidget(
                  'Must have own van or truck'.tr,
                ),
                setHeight(15),
                Row(
                  children: [
                    Expanded(
                      child: setTextField(
                        controller: controller.taskController,
                        height: 45,
                        hint: 'What much they have or do?'.tr,
                        hintColor: AppColors.gray1.lightColorHex(),
                      ),
                    ),
                    setWidth(15),
                    InkWell(
                      onTap: () {
                        if (controller.taskController.text.isNotEmpty) {
                          con.addTask();
                          FocusScope.of(context).requestFocus(FocusNode());
                        } else {
                          AlertClass.shared.setSnackbar('Please add note'.tr);
                        }
                      },
                      child: setCommonText(
                        'Add'.tr,
                        fontSize: 16,
                        color: AppColors.colorPrimaryDark.lightColorHex(),
                        fontWeight: FontWeight.w500,
                        noOfLine: 3,
                      ),
                    )
                  ],
                ),
                setHeight(20),
                Expanded(
                    child: ListView.builder(
                        itemCount: con.taskList.length,
                        itemBuilder: (context, index) {
                          final item = con.taskList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    child: setCommonText(
                                  '${index + 1}.  ${item.title}',
                                  noOfLine: 2,
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                )),
                                setWidth(10),
                                InkWell(
                                    onTap: () {
                                      con.removeTask(index);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          );
                        })),
                (con.taskList.length > 0)
                    ? createButton(
                        text: 'Save'.tr,
                        txtColor: AppColors.white.lightColorHex(),
                        onBtnClick: () {
                          NavigationService().setPopNavigator();
                        },
                      )
                    : setHeight(0),
              ],
            ),
          );
        },
      ),
    );
  }
}
