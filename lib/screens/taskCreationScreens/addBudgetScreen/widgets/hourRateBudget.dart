// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskCreationScreens/controller/addTaskController.dart';
import 'package:get/get.dart';

class HourRateBudget extends StatefulWidget {
  const HourRateBudget({Key? key}) : super(key: key);

  @override
  State<HourRateBudget> createState() => _HourRateBudgetState();
}

class _HourRateBudgetState extends State<HourRateBudget> with TextFieldMixin {
  final controllerTask = Get.put(AddTaskController());

  //Methods
  _setComonWidget(String name, String hint, double height, int lines,
      TextEditingController controller) {
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
            height: height,
            controller: controller,
            hint: hint,
            hintColor: AppColors.gray.lightColorHex(),
            fontSize: 14,
            isLabelHidden: true,
            isVisibleBorder: false,
            onTextChange: (value) {
              controllerTask.calculatePrice();
            },
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            contentPadding: EdgeInsets.only(top: 12, left: 5),
            isSecureText: false,
            isMaxline: lines),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
              child: _setComonWidget(
                  'Hours'.tr, 'e.g 3', 45, 1, controllerTask.hourController)),
          setWidth(5),
          Expanded(
              child: _setComonWidget('Price per hour'.tr, 'e.g 19', 45, 1,
                  controllerTask.hourRateController)),
        ],
      ),
    );
  }
}
