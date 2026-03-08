import 'dart:developer';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/modelCategory.dart';
import 'package:fixz/screens/taskCreationScreens/createTask/createTaksScreen.dart';
import 'package:fixz/screens/taskCreationScreens/subCategoryScreen/viewerSubCatList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen();

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //Category List
  List<CategoryData> categoryList = [];
  bool isSelectCategory = false;
  final controller = Get.put(AddTaskController());

  getLocalCategoryData() async {
    final String response =
        await rootBundle.loadString('assets/jsonFile/categoryFile.json');
    CategoryList result = CategoryList.fromJson(json.decode(response));
    categoryList = result.data!;
    setState(() {});
  }

  _getCategoryList() async {
    ApiProvider _apiProvider = ApiProvider();
    // this.repairRequestList[index].status = status;
    await _apiProvider.getCategoryList().then((value) {
      // debugPrint('==========response:=>${value.data[0].image}');
      if (value.message == 'success') {
        categoryList = value.data!;
        log('category list:${jsonEncode(categoryList)}');
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: value.message!);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocalCategoryData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryList();
    });
  }

  String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [],
    //     title: Text(
    //       'Select Task Category',
    //       style: TextStyle(color: AppColors.black.lightColorHex()),
    //     ),
    //     backgroundColor: AppColors.white.lightColorHex(),
    //     iconTheme: IconThemeData(
    //       color: AppColors.black.lightColorHex(),
    //     ),
    //   ),
    //   body: Container(
    //     color: AppColors.white.lightColorHex(),
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: GridView.count(
    //               crossAxisCount: 2,
    //               children: List<Widget>.generate(categoryList.length, (index) {
    //                 final item = categoryList[index];
    //                 final extension = getFileExtension(item.image!);
    //                 return GridTile(
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: InkWell(
    //                       onTap: () {
    //                         if (item.subCategories!.length == 0) {
    //                           isSelectCategory = true;
    //                           categoryList
    //                               .where((element) =>
    //                                   element.isSelectCategory = false)
    //                               .toList();
    //                           setState(() {
    //                             item.isSelectCategory = true;
    //                           });
    //                         } else {
    //                           controller.selectCategory(item.id.toString());
    //                           setState(() {
    //                             categoryList
    //                                 .where((element) =>
    //                                     element.isSelectCategory = false)
    //                                 .toList();
    //                             isSelectCategory = false;
    //                           });
    //                           NavigationService()
    //                               .setNavigator(ViewerSubCategoryList(
    //                             category: item,
    //                             title: item.title!,
    //                           ));
    //                         }
    //                       },
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             border: Border.all(
    //                               color: Colors.grey.shade200,
    //                             ),
    //                             borderRadius: BorderRadius.circular(12),
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.grey.shade300,
    //                                 offset: const Offset(0, 0),
    //                                 spreadRadius: 0.1,
    //                                 blurRadius: 2,
    //                               )
    //                             ]),
    //                         child: Stack(
    //                           alignment: Alignment.center,
    //                           children: [
    //                             Column(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 (extension != '.svg')
    //                                     ? ClipRRect(
    //                                         child: setNetworkImage(
    //                                             item.image!, 80, 80),
    //                                       )
    //                                     : Padding(
    //                                         padding: const EdgeInsets.symmetric(
    //                                             horizontal: 15.0),
    //                                         child: SvgPicture.network(
    //                                           item.image!,
    //                                           height: 80,
    //                                           width: 80,
    //                                           fit: BoxFit.fill,
    //                                         ),
    //                                       ),
    //                                 setHeight(10),
    //                                 setCommonText(
    //                                   '${item.title}',
    //                                   fontSize: 12,
    //                                   noOfLine: 2,
    //                                   textAlignment: TextAlign.center,
    //                                 )
    //                               ],
    //                             ),
    //                             (!item.isSelectCategory!)
    //                                 ? Container()
    //                                 : Positioned(
    //                                     right: 5,
    //                                     top: 5,
    //                                     child: Icon(
    //                                       Icons.check_box,
    //                                       color: AppColors.colorPrimaryDark
    //                                           .lightColorHex(),
    //                                     ))
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }),
    //             ),
    //           ),
    //           // setHeight(5),
    //           // (isSelectCategory)
    //           //     ? InkWell(
    //           //         onTap: () {
    //           //           List<CategoryData> value = categoryList
    //           //               .where((element) => element.isSelectCategory!)
    //           //               .toList();

    //           //           // RequestRaiperModels requestRaiperModels =
    //           //           //     RequestRaiperModels();
    //           //           // requestRaiperModels.typeRepair = 0;
    //           //           // requestRaiperModels.property = widget.property;

    //           //           // Navigator.of(context).push(MaterialPageRoute(
    //           //           //     builder: (context) => RequestRepairScreen3(
    //           //           //           requestRaiperModels: requestRaiperModels,
    //           //           //           model: model,
    //           //           //           categoryId: value[0].id.toString(),
    //           //           //           subcategoryId: '0',
    //           //           //         )));
    //           //           controller
    //           //               .selectCategory(categoryList[0].id.toString());
    //           //           NavigationService().setNavigator(CreateNewTask());
    //           //         },
    //           //         child: Container(
    //           //             height: 45,
    //           //             width: double.infinity,
    //           //             alignment: Alignment.center,
    //           //             decoration: BoxDecoration(
    //           //               color: AppColors.colorPrimaryDark.lightColorHex(),
    //           //               borderRadius: BorderRadius.circular(5),
    //           //             ),
    //           //             child: setCommonText('Continue',
    //           //                 color: AppColors.white.lightColorHex(),
    //           //                 fontSize: 14)),
    //           //       )
    //           //     : setHeight(0),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Select Task Category'.tr,
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
                  children: List<Widget>.generate(categoryList.length, (index) {
                    final item = categoryList[index];
                    final extension = getFileExtension(item.image!);
                    return GridTile(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (item.subCategories!.isEmpty) {
                              isSelectCategory = true;
                              categoryList
                                  .where((element) =>
                                      element.isSelectCategory = false)
                                  .toList();
                              setState(() {
                                item.isSelectCategory = true;
                              });
                            } else {
                              controller.selectCategory(item.id.toString());
                              setState(() {
                                categoryList
                                    .where((element) =>
                                        element.isSelectCategory = false)
                                    .toList();
                                isSelectCategory = false;
                              });
                              NavigationService()
                                  .setNavigator(ViewerSubCategoryList(
                                category: item,
                                title: item.title!,
                              ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //Local Json File Img
                                    // Image(
                                    //   image: AssetImage(item.image!),
                                    //   height: 80,
                                    //   width: 80,
                                    //   fit: BoxFit.contain,
                                    // ),

                                    //Network URL
                                    // (extension != '.svg')
                                    //     ? ClipRRect(
                                    //         child: setNetworkImage(
                                    //             item.image!, 80, 80),
                                    //       )
                                    //     : Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 15.0),
                                    //         child: SvgPicture.network(
                                    //           item.image!,
                                    //           height: 80,
                                    //           width: 80,
                                    //           fit: BoxFit.fill,
                                    //         ),
                                    //       ),
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Lottie.asset(
                                        SharedManager.shared
                                            .getJsonFileURL('${item.title}'),
                                      ),
                                    ),
                                    setHeight(10),
                                    setCommonText(
                                      '${item.title}',
                                      fontSize: 14,
                                      noOfLine: 2,
                                      textAlignment: TextAlign.center,
                                    )
                                  ],
                                ),
                                (!item.isSelectCategory!)
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
              setHeight(5),
              (isSelectCategory)
                  ? InkWell(
                      onTap: () {
                        List<CategoryData> value = categoryList
                            .where((element) => element.isSelectCategory!)
                            .toList();

                        // RequestRaiperModels requestRaiperModels =
                        //     RequestRaiperModels();
                        // requestRaiperModels.typeRepair = 0;
                        // requestRaiperModels.property = widget.property;

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => RequestRepairScreen3(
                        //           requestRaiperModels: requestRaiperModels,
                        //           model: model,
                        //           categoryId: value[0].id.toString(),
                        //           subcategoryId: '0',
                        //         )));
                        controller.selectCategory(value[0].id.toString());
                        NavigationService().setNavigator(CreateNewTask());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                            height: 45,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.colorPrimaryDark.lightColorHex(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: setCommonText('Continue'.tr,
                                color: AppColors.white.lightColorHex(),
                                fontSize: 14)),
                      ),
                    )
                  : setHeight(0),
            ],
          ),
        ),
      ),
    );
  }
}
