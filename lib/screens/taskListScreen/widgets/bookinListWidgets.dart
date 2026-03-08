// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskCreationScreens/categoryScreen/categoryScreen.dart';
import 'package:fixz/screens/taskDetails/bookingTaskDetails/bookingTaskDetails.dart';
import 'package:fixz/screens/taskListScreen/controller/taskListController.dart';

class BookingWidgets extends StatefulWidget {
  const BookingWidgets({Key? key}) : super(key: key);

  @override
  State<BookingWidgets> createState() => _BookingWidgetsState();
}

class _BookingWidgetsState extends State<BookingWidgets> with ButtonMixin {
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
    controller.getTaskList('1');
  }

  _setComonRow(String title, IconData icon, {bool isCenter = true}) {
    return Row(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey.shade500,
          size: 18,
        ),
        setWidth(3),
        Expanded(
          child: setCommonText(
            title,
            fontSize: 12,
            color: Colors.black45,
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
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
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
                                vertical: 8.0, horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                NavigationService()
                                    .setNavigator(BookingTaskDetails(
                                  taskId: item.id.toString(),
                                  // reviwed: item.isReviewed!,
                                  // status: item.status.toString(),
                                ));
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.white.lightColorHex(),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1.0,
                                            blurRadius: 1.0,
                                            color: Colors.grey.shade300,
                                            offset: Offset(0, 0)),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  setCommonText(
                                                    item.details ??
                                                        'No data'.tr,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    noOfLine: 2,
                                                  ),
                                                  setHeight(5),
                                                  _setComonRow(
                                                      item.location ??
                                                          'No data'.tr,
                                                      Icons.place,
                                                      isCenter: false),
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
                                      ),
                                      createButton(
                                        height: 30,
                                        width: 80,
                                        fontSize: 12,
                                        txtColor:
                                            AppColors.white.lightColorHex(),
                                        text: (item.status == 0)
                                            ? 'Accepted'.tr
                                            : 'Completed'.tr,
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        }).addPulltoRefresh((status) {
                        _getTaskList();
                      }),
          );
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
