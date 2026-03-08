// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskCreationScreens/categoryScreen/categoryScreen.dart';
import 'package:fixz/screens/taskDetails/taskDetails/taskDetails/taskDetails.dart';
import 'package:fixz/screens/taskListScreen/controller/taskListController.dart';

class TasksWidgets extends StatefulWidget {
  const TasksWidgets({Key? key}) : super(key: key);

  @override
  State<TasksWidgets> createState() => _TasksWidgetsState();
}

class _TasksWidgetsState extends State<TasksWidgets> with ButtonMixin {
  final controller = Get.put(TaskListController());

  // List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      _getTaskList();
    });
  }

  _getTaskList() {
    controller.getTaskList('0');
  }

  _setComonRow(String title, IconData icon, {bool isStart = false}) {
    return Row(
      crossAxisAlignment:
          isStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isStart ? Colors.black54 : Colors.grey.shade500,
          size: 18,
        ),
        setWidth(6),
        Expanded(
          child: setCommonText(
            title,
            fontSize: 14,
            color: isStart ? Colors.black54 : Colors.black45,
            fontWeight: FontWeight.w400,
            noOfLine: 2,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TaskListController>(
        builder: (con) {
          return Container(
              color: AppColors.white.lightColorHex(),
              padding: EdgeInsets.all(10),
              child: (con.taskList.isEmpty)
                  ? Center(
                      child: createButton(
                          onBtnClick: () {
                            NavigationService().setNavigator(CategoryScreen());
                          },
                          width: 300,
                          text: 'Request Service Provider'.tr,
                          txtColor: Colors.white),
                    )
                  : (con.loading)
                      ? Container()
                      : ListView.builder(
                          itemCount: con.taskList.length,
                          itemBuilder: (context, index) {
                            final item = con.taskList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => TaskDetails(
                                              taskId: item.id.toString())))
                                      .then((value) {
                                    if (value == 'yes') {
                                      _getTaskList();
                                    }
                                  });
                                  // await NavigationService().setNavigator(TaskDetails(
                                  //   taskId: item.id.toString(),
                                  // ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.white.lightColorHex(),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2.0,
                                              blurRadius: 1.0,
                                              color: Colors.grey.shade200,
                                              offset: Offset(0, 0)),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            setCommonText(
                                              item.details ?? 'No Details'.tr,
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              noOfLine: 1,
                                            ),
                                            setHeight(5),
                                            _setComonRow(
                                              item.location ?? 'No Location'.tr,
                                              Icons.place,
                                              isStart: true,
                                            ),
                                            setHeight(5),
                                            _setComonRow(
                                                item.repairingDate ??
                                                    'No data'.tr,
                                                Icons.calendar_today),
                                            setHeight(5),
                                            _setComonRow(
                                              getStringwithNewLine(
                                                  '${item.time}'),
                                              Icons.watch_later_outlined,
                                            ),
                                            setHeight(10),
                                            Row(
                                              children: [
                                                setCommonText(
                                                  "POSTED".tr,
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w500,
                                                  noOfLine: 1,
                                                ),
                                                setWidth(5),
                                                setCommonText(
                                                  '${item.totalQuotation} ${'offers'.tr}',
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  noOfLine: 1,
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                        setWidth(5),
                                        // setCommonText(
                                        //   '£${item.rate}',
                                        //   fontSize: 20,
                                        //   color: Colors.black,
                                        //   fontWeight: FontWeight.w800,
                                        //   noOfLine: 1,
                                        // ),
                                      ],
                                    )),
                              ),
                            );
                          }).addPulltoRefresh((vale) {
                          _getTaskList();
                        }));
        },
      ),
    );
  }
}

extension PULLTORefresh on Widget {
  addPulltoRefresh(Function(bool) pull) {
    return RefreshIndicator(
        color: AppColors.colorPrimaryDark.lightColorHex(),
        child: this,
        onRefresh: () async {
          return Future.delayed(Duration(milliseconds: 300), () {
            pull(true);
          });
        });
  }
}
