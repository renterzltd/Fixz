// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/modelCategory.dart';
import 'package:fixz/screens/taskCreationScreens/createTask/createTaksScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class ViewerSubCategoryList extends StatefulWidget {
  final CategoryData category;
  final String title;
  const ViewerSubCategoryList({
    Key? key,
    required this.category,
    required this.title,
  }) : super(key: key);

  @override
  State<ViewerSubCategoryList> createState() => _ViewerSubCategoryListState();
}

class _ViewerSubCategoryListState extends State<ViewerSubCategoryList> {
  //MARK: Variables
  final controller = Get.find<AddTaskController>();
  bool isSelectCategory = false;
  //MARK: Methods
  String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.selectSubCategoryId('0');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            widget.title,
            style: TextStyle(color: AppColors.black.lightColorHex()),
          ),
          backgroundColor: AppColors.white.lightColorHex(),
          iconTheme: IconThemeData(
            color: AppColors.black.lightColorHex(),
          ),
        ),
        body: Container(
          color: AppColors.white.lightColorHex(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List<Widget>.generate(
                        widget.category.subCategories?.length ?? 0, (index) {
                      final item = widget.category.subCategories![index];
                      final extension = getFileExtension(item.image!);
                      log("Image Extension:$extension");
                      return GridTile(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              isSelectCategory = true;
                              widget.category.subCategories!
                                  .where((element) => element.isSelect = false)
                                  .toList();
                              setState(() {
                                controller
                                    .selectSubCategoryId(item.id.toString());
                                widget.category.subCategories![index].isSelect =
                                    true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(0, 0),
                                      spreadRadius: 0.1,
                                      blurRadius: 2,
                                    )
                                  ]),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image(
                                      //   image: AssetImage(item.image!),
                                      //   height: 80,
                                      //   width: 80,
                                      //   fit: BoxFit.contain,
                                      // ),
                                      // (extension == '.svg')
                                      //     ? Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 horizontal: 15.0),
                                      //         child: SvgPicture.network(
                                      //           item.image!,
                                      //           height: 80,
                                      //           width: 80,
                                      //           fit: BoxFit.fill,
                                      //         ),
                                      //       )
                                      //     : Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 horizontal: 15.0),
                                      //         child: ClipRRect(
                                      //           child: setNetworkImage(
                                      //               item.image ?? "", 80, 80),
                                      //         )),
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Lottie.asset(
                                          SharedManager.shared
                                              .getJsonFileURL('${item.title}'),
                                        ),
                                      ),
                                      setHeight(10),
                                      setHeight(8),
                                      setCommonText(
                                        '${item.title}',
                                        fontSize: 14,
                                        noOfLine: 2,
                                        textAlignment: TextAlign.center,
                                      )
                                    ],
                                  ),
                                  (!item.isSelect!)
                                      ? Container()
                                      : Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Icon(
                                            Icons.check_box,
                                            color: AppColors.colorPrimaryDark
                                                .lightColorHex(),
                                          ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.selectCategory(widget.category.id.toString());
                    NavigationService().setNavigator(CreateNewTask());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: (isSelectCategory)
                        ? Container(
                            height: 45,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.colorPrimaryDark.lightColorHex(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: setCommonText('Continue'.tr,
                                color: AppColors.white.lightColorHex(),
                                fontSize: 14))
                        : setWidth(5),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
