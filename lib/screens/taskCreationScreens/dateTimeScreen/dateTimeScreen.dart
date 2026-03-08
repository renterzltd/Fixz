// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';

import 'widgets/timePickerWidget.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({Key? key}) : super(key: key);

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  final controller = Get.put(AddTaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Post Task'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                controller.selectDate(context);
              },
              child: setTextField(
                  controller: controller.dateController,
                  isEditable: false,
                  height: 45,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  hint: 'Select date'.tr,
                  fontSize: 16,
                  hintColor: Colors.grey,
                  contentPadding: EdgeInsets.only(top: 12, left: 5)),
            ),
            // setHeight(15),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.check_box_outline_blank,
            //       color: Colors.grey,
            //     ),
            //     setWidth(10),
            //     Expanded(
            //       child: setCommonText(
            //         'I need certain time of day',
            //         fontSize: 16,
            //         color: AppColors.gray.lightColorHex(),
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ],
            // ),
            setHeight(25),
            // InkWell(
            //   onTap: () {
            //     controller.selectTime(context);
            //   },
            //   child: setTextField(
            //       controller: controller.timeController,
            //       isEditable: false,
            //       height: 45,
            //       prefixIcon: Icon(
            //         Icons.watch_later_outlined,
            //         color: Colors.grey,
            //         size: 22,
            //       ),
            //       suffixIcon: Icon(
            //         Icons.keyboard_arrow_down_rounded,
            //         color: Colors.grey,
            //         size: 30,
            //       ),
            //       hint: 'Select Time'.tr,
            //       hintColor: Colors.grey,
            //       fontSize: 16,
            //       contentPadding: EdgeInsets.only(top: 12, left: 5)),
            // ),
            SpecificTImeWidget(),
            setHeight(80),
            createButton(
                text: 'Continue'.tr,
                fontSize: 15,
                txtColor: AppColors.white.lightColorHex(),
                onBtnClick: () {
                  controller.continueFromDateTimeScreen();
                }),
          ],
        ),
      ),
    );
  }
}
