import 'package:fixz/hdHelper/exportFile.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with AppbarMixin, ButtonMixin, TextFieldMixin {
  final controller = Get.put(TaskAlertController());

  _setTaskTypeWidget(TextEditingController controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          setHeight(15),
          setCommonText(
            'What specific kind of task?'.tr,
            noOfLine: 1,
            fontSize: 15,
            color: Colors.black,
          ),
          setHeight(8),
          setTextField(
            height: 40,
            hint: 'Add task'.tr,
            hintColor: Colors.grey.shade400,
            controller: controller,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Add task alerts'.tr,
          bgColor: AppColors.colorPrimaryDark.lightColorHex(),
          textColor: AppColors.white.lightColorHex(),
          backIconColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<TaskAlertController>(
        builder: (con) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // setCommonText(
                //   'What type of task are you looking for?',
                //   noOfLine: 1,
                //   fontSize: 16,
                //   color: Colors.black,
                // ),
                // setHeight(8),
                // Row(
                //   children: [
                //     Row(
                //       children: [
                //         Icon(
                //           Icons.radio_button_off,
                //           size: 20,
                //         ),
                //         setWidth(5),
                //         setCommonText(
                //           'In Person',
                //           noOfLine: 1,
                //           fontSize: 15,
                //           color: Colors.grey,
                //         ),
                //       ],
                //     ),
                //     setWidth(15),
                //     Row(
                //       children: [
                //         Icon(
                //           Icons.radio_button_checked,
                //           size: 20,
                //           color: AppColors.colorPrimaryDark.lightColorHex(),
                //         ),
                //         setWidth(5),
                //         setCommonText(
                //           'Remote',
                //           noOfLine: 1,
                //           fontSize: 15,
                //           color: Colors.grey,
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                setHeight(15),
                _setTaskTypeWidget(con.taskTitleController),
                setHeight(35),
                createButton(
                    text: 'Add your task alert'.tr,
                    txtColor: Colors.white,
                    onBtnClick: () {
                      controller.addTask();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
