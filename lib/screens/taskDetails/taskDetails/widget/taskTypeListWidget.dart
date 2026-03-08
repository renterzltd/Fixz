import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/material.dart';

class TaskTypeListWidget extends StatefulWidget {
  final String status;
  const TaskTypeListWidget({Key? key, required this.status}) : super(key: key);

  @override
  State<TaskTypeListWidget> createState() => _TaskTypeListWidgetState();
}

class _TaskTypeListWidgetState extends State<TaskTypeListWidget> {
  List<TaskType> taskTypeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskTypeList = [
      TaskType(title: 'OPEN'.tr, isSelect: true),
      TaskType(title: 'ASSIGNED'.tr, isSelect: false),
      TaskType(title: 'COMPLETED'.tr, isSelect: false),
      TaskType(title: 'REVIEWED'.tr, isSelect: false),
    ];
    switch (widget.status) {
      case '0':
        _fillArrayStatus(1);
        break;
      case '1':
        _fillArrayStatus(2);
        break;
      case '2':
        _fillArrayStatus(3);
        break;
      case '3':
        _fillArrayStatus(4);
        break;
      default:
    }
  }

  _fillArrayStatus(int count) {
    for (int i = 0; i < count; i++) {
      taskTypeList[i].isSelect = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
          itemCount: taskTypeList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: InkWell(
                // onTap: () {
                // taskTypeList
                //     .where((element) => element.isSelect = false)
                //     .toList();
                // setState(() {
                //   taskTypeList[index].isSelect = true;
                // });
                // },
                child: Chip(
                  label: Text(
                    taskTypeList[index].title,
                    style: TextStyle(
                      fontSize: 12,
                      color: taskTypeList[index].isSelect
                          ? AppColors.white.lightColorHex()
                          : Colors.black54,
                    ),
                  ),
                  backgroundColor: taskTypeList[index].isSelect
                      ? AppColors.colorPrimaryDark.lightColorHex()
                      : Colors.grey.shade300,
                ),
              ),
            );
          }),
    );
  }
}

class TaskType {
  String title;
  bool isSelect;
  TaskType({this.title = "", this.isSelect = false});
}
