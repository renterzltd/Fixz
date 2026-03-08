// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:get/get.dart';

import 'addTaskScreen.dart';
import 'taskAlertController.dart';

class TaskAlertScreen extends StatefulWidget {
  const TaskAlertScreen({Key? key}) : super(key: key);

  @override
  State<TaskAlertScreen> createState() => _TaskAlertScreenState();
}

class _TaskAlertScreenState extends State<TaskAlertScreen>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(TaskAlertController());
  _setTopNoteWithToggleSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Icon(
                Icons.check_box,
                color: Colors.grey,
              ),
              setWidth(8),
              Expanded(
                child: setCommonText(
                  'Get notified when new tasks are posted based on keywords and preferences you choose',
                  noOfLine: 4,
                  color: Colors.grey,
                ),
              ),
            ])),
        setHeight(15),
        setCommonText(
          'ADD YOUR KEYWORDS AND PREFERENCES',
          noOfLine: 4,
        ),
        setHeight(8),
        setCommonText(
          'You will be notified when tasks containing your keywords are posted. You can choose how to get notified in Notification Settings.',
          noOfLine: 10,
          fontSize: 12,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Task alerts',
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<TaskAlertController>(
        builder: (con) {
          return Container(
            padding: EdgeInsets.all(25),
            color: AppColors.white.lightColorHex(),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _setTopNoteWithToggleSwitch(),
                      setHeight(8),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: con.alertTaskList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: setCommonText(
                                        con.alertTaskList[index].title,
                                      ),
                                    ),
                                    setWidth(8),
                                    InkWell(
                                      onTap: () {
                                        con.removeTask(index);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.colorPrimaryDark
                                            .lightColorHex(),
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                setHeight(15),
                createButton(
                    text: 'Add keyword-based task alert',
                    txtColor: Colors.white,
                    onBtnClick: () {
                      NavigationService().setNavigator(
                        AddTaskScreen(),
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
