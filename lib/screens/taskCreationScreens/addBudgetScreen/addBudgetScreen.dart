// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/cupertino.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key}) : super(key: key);

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen>
    with AppbarMixin, ButtonMixin {
  final controller = Get.put(AddTaskController());

  Widget buildSegment(String text) {
    return SizedBox(
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }

  _setTaskImageBorderWidget(
    int index,
  ) {
    return InkWell(
      onTap: () async {
        XFile? image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 60);
        if (image != null) {
          controller.fillImage(index, File(image.path));
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 3) - 40,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.camera_alt_outlined,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  _setImageWidget() {
    return GetBuilder<AddTaskController>(
      builder: (con) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                setCommonText(
                  'Add Task Images'.tr,
                  fontSize: 16,
                  color: AppColors.Black.lightColorHex(),
                  fontWeight: FontWeight.bold,
                ),
                setWidth(3),
                setCommonText(
                  '(optional)'.tr,
                  fontSize: 12,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            setHeight(8),
            SizedBox(
              height: (MediaQuery.of(context).size.width / 3) - 40,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      _setTaskImageBorderWidget(0),
                      (con.imageFile1 != null)
                          ? Stack(
                              children: [
                                ClipRRect(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    height: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    width: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    image: FileImage(con.imageFile1!),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    con.deletImage(0);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                          : setHeight(3)
                    ],
                  ),
                  Stack(
                    children: [
                      _setTaskImageBorderWidget(1),
                      (con.imageFile2 != null)
                          ? Stack(
                              children: [
                                ClipRRect(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    height: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    width: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    image: FileImage(con.imageFile2!),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    con.deletImage(1);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                          : setHeight(3)
                    ],
                  ),
                  Stack(
                    children: [
                      _setTaskImageBorderWidget(2),
                      (con.imageFile3 != null)
                          ? Stack(
                              children: [
                                ClipRRect(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    height: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    width: (MediaQuery.of(context).size.width /
                                            3) -
                                        40,
                                    image: FileImage(con.imageFile3!),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    con.deletImage(2);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                          : setHeight(3)
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

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
                // Container(
                //   alignment: Alignment.center,
                //   // padding: EdgeInsets.all(10),
                //   child: CupertinoSlidingSegmentedControl<int>(
                //     backgroundColor: Colors.grey.shade400,
                //     thumbColor: AppColors.colorPrimaryDark.lightColorHex(),
                //     groupValue: con.groupValue,
                //     children: {
                //       0: buildSegment('Fixed rate'.tr),
                //       1: buildSegment("Hourly rate".tr),
                //     },
                //     onValueChanged: (value) {
                //       controller.updateGroupValue(value!);
                //       log(' Value is: $value');
                //       con.selectBudgetType(value);
                //       controller.calculatePrice();
                //     },
                //   ),
                // ),
                // setHeight(15),
                // // ignore: prefer_const_constructors
                // con.isFixedRate ? FixedRateBudget() : HourRateBudget(),
                // setHeight(40),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     setCommonText(
                //       "Estimate Budget:".tr,
                //       fontSize: 14,
                //       color: AppColors.black.lightColorHex(),
                //       fontWeight: FontWeight.w500,
                //     ),
                //     setHeight(5),
                //     setCommonText(
                //       "\£${con.price}",
                //       fontSize: 18,
                //       color: AppColors.black.lightColorHex(),
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ],
                // ),
                setHeight(30),
                _setImageWidget(),
                setHeight(50),
                createButton(
                    text: 'Post Task'.tr,
                    fontSize: 15,
                    txtColor: AppColors.white.lightColorHex(),
                    onBtnClick: () {
                      controller.finalPostTaskAPI();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
