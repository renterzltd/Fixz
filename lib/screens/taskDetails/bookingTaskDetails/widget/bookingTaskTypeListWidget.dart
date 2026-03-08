import 'package:fixz/hdHelper/exportFile.dart';

class BookingTaskTypeListWidget extends StatefulWidget {
  const BookingTaskTypeListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingTaskTypeListWidget> createState() =>
      _BookingTaskTypeListWidgetState();
}

class _BookingTaskTypeListWidgetState extends State<BookingTaskTypeListWidget> {
  final controller = Get.find<TaskDetailController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailController>(
      builder: (con) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
              itemCount: con.taskTypeList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      // con.taskTypeList
                      //     .where((element) => element.isSelect = false)
                      //     .toList();
                      // setState(() {
                      //   con.taskTypeList[index].isSelect = true;
                      // });
                    },
                    child: Chip(
                      label: Text(
                        controller.taskTypeList[index].title,
                        style: TextStyle(
                          fontSize: 12,
                          color: controller.taskTypeList[index].isSelect
                              ? AppColors.white.lightColorHex()
                              : Colors.black54,
                        ),
                      ),
                      backgroundColor: controller.taskTypeList[index].isSelect
                          ? AppColors.colorPrimaryDark.lightColorHex()
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
