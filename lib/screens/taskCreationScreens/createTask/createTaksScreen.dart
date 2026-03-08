// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskCreationScreens/mustHavePage/mustHaveScreen.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  final controller = Get.find<AddTaskController>();
  //Methods
  _setComonWidget(String name, String hint, double height, int lines,
      TextEditingController controller,
      {bool isEditable = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setCommonText(
          name,
          fontSize: 14,
          color: AppColors.black.lightColorHex(),
          fontWeight: FontWeight.w500,
        ),
        setHeight(8),
        setTextField(
            controller: controller,
            isEditable: isEditable,
            height: height,
            hint: hint,
            hintColor: AppColors.gray.lightColorHex(),
            fontSize: 14,
            isLabelHidden: true,
            isVisibleBorder: false,
            keyboardType: TextInputType.text,
            isSecureText: false,
            isMaxline: lines),
      ],
    );
  }

  _setAdditionalTaskList() {
    return GetBuilder<AddTaskController>(
      builder: (con) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
            });
      },
    );
  }

  // _selectLocation() async {
  //   String placeName;
  //   var place = await PluginGooglePlacePicker.showAutocomplete(
  //       mode: PlaceAutocompleteMode.MODE_OVERLAY,
  //       typeFilter: TypeFilter.GEOCODE);
  //   placeName = place.name ?? "Null place name!".tr;
  //   if (!mounted) return;
  //   debugPrint("Place Name:$placeName");
  //   controller.addLocation(
  //       placeName, place.latitude.toString(), place.longitude.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Post Task'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: GetBuilder<AddTaskController>(
        builder: (con) {
          return Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                _setComonWidget(
                  'Task title'.tr,
                  'Enter title'.tr,
                  40,
                  1,
                  controller.titleController,
                ),
                setHeight(25),
                _setComonWidget(
                  'Describe your task'.tr,
                  'write here'.tr,
                  100,
                  5,
                  controller.descriptionController,
                ),
                // setHeight(15),
                // InkWell(
                //   onTap: () {
                //     NavigationService().setNavigator(MustHaveScreen());
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.add_circle_outline_sharp,
                //         color: AppColors.colorPrimaryDark.lightColorHex(),
                //       ),
                //       setWidth(5),
                //       setCommonText(
                //         'Add must haves'.tr,
                //         fontSize: 15,
                //         color: AppColors.colorPrimaryDark.lightColorHex(),
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ],
                //   ),
                // ),
                _setAdditionalTaskList(),
                // setHeight(15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     setCommonText(
                //       'Can this task completed remotely?'.tr,
                //       fontSize: 14,
                //       color: AppColors.black.lightColorHex(),
                //       fontWeight: FontWeight.w400,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         controller.updateTaskType();
                //       },
                //       child: Icon(
                //         (con.isRemotTask)
                //             ? Icons.toggle_on
                //             : Icons.toggle_off_outlined,
                //       ),
                //     )
                //   ],
                // ),
                // setHeight(15),
                // InkWell(
                //   onTap: () {
                //     _selectLocation();
                //   },
                //   child: _setComonWidget('Task Location(Postcode)'.tr,
                //       'Enter location'.tr, 40, 1, controller.locationController,
                //       isEditable: false),
                // ),
                setHeight(100),
                createButton(
                    text: 'NEXT'.tr,
                    fontSize: 15,
                    txtColor: AppColors.white.lightColorHex(),
                    onBtnClick: () {
                      con.continueFromTitlePage();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
