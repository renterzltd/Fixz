// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/taskCreationScreens/controller/addTaskController.dart';
import 'package:get/get.dart';

class FixedRateBudget extends StatefulWidget {
  const FixedRateBudget({Key? key}) : super(key: key);

  @override
  State<FixedRateBudget> createState() => _FixedRateBudgetState();
}

class _FixedRateBudgetState extends State<FixedRateBudget> with TextFieldMixin {
  final controller = Get.put(AddTaskController());

  //Methods
  _setComonWidget(
    String name,
    String hint,
    double height,
    int lines,
  ) {
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
            controller: controller.fixedRateController,
            hint: hint,
            hintColor: AppColors.gray.lightColorHex(),
            fontSize: 14,
            isLabelHidden: true,
            isVisibleBorder: false,
            onTextChange: (value) {
              controller.calculatePrice();
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
    return Container(
      child: _setComonWidget('Whats your budget?'.tr, 'e.g 150', 45, 1),
    );
  }
}
