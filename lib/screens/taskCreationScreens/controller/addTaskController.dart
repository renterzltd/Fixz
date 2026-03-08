// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_is_empty

import 'dart:developer';
import 'dart:io';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/model/model_address_list_based_on_postcode.dart';
import 'package:fixz/screens/taskCreationScreens/addBudgetScreen/addBudgetScreen.dart';
import 'package:fixz/screens/taskCreationScreens/selectAddress/selectAddress.dart';
import 'package:fixz/util/extension.dart';

class AddTaskController extends GetxController {
  List<CertainTime> specificTimeList = [];
  List<PostCodeAddress> addressList = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController fixedRateController = TextEditingController();
  TextEditingController hourRateController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController locationController = TextEditingController();
  // ApiProvider _apiProvider = ApiProvider();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  bool isFixedRate = true;
  bool isRemotTask = false;
  String price = '0.0';
  String categoryId = '';
  String subCategoryId = '0';

  // String latitude = '0.0';
  // String longitude = '0.0';

  static String addLat = '';
  static String addLng = '';
  static String city = '';
  static String address = '';
  static String apartNo = '';
  static String floor = '';
  static String addressLabel = '';
  static String addressType = '';

  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

//Segment Controller
  int groupValue = 0;

//Must Have Screen
  List<Task> taskList = [];
  TextEditingController taskController = TextEditingController();
  int index = 0;

  List<LOCATION> locationType = [
    LOCATION(isSelect: false, title: 'Apartment', icon: Icons.apartment),
    LOCATION(isSelect: false, title: 'House', icon: Icons.house_outlined),
    LOCATION(
        isSelect: false, title: 'Office', icon: Icons.shopping_bag_outlined),
  ];

//MARK: Lifecycle Method

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fillData();
  }

  selectAddressType(int myIndex) {
    locationType.where((element) => element.isSelect = false).toList();
    locationType[myIndex].isSelect = true;
    update();
  }

  updateGroupValue(int value) {
    groupValue = value;
    update();
  }

  fillImage(int index, File image) async {
    switch (index) {
      case 0:
        imageFile1 = image;
        break;
      case 1:
        imageFile2 = image;
        break;
      case 2:
        imageFile3 = image;
        break;
      default:
    }
    update();
  }

  deletImage(
    int index,
  ) {
    switch (index) {
      case 0:
        imageFile1 = null;
        break;
      case 1:
        imageFile2 = null;
        break;
      case 2:
        imageFile3 = null;
        break;
      default:
    }
    update();
  }

//MARK: Button Action Methos with Validatons
  continueFromTitlePage() {
    if (titleController.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter title'.tr);
      return;
    } else if (descriptionController.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please enter description'.tr);
      return;
    }
    //  else if (locationController.text.isEmpty) {
    //   AlertClass.shared.setSnackbar('Please enter task location'.tr);
    //   return;
    // }
    NavigationService().setNavigator(SelectAddressPage());
  }

  continueFromDateTimeScreen() {
    final tmpTimeArray =
        specificTimeList.where((element) => element.isSelect == true).toList();
    if (dateController.text.isEmpty) {
      AlertClass.shared.setSnackbar('Please select date first'.tr);
      return;
    } else if (tmpTimeArray.isEmpty) {
      AlertClass.shared.setSnackbar('Please select specific service time'.tr);
      return;
    }
    NavigationService().setNavigator(AddBudgetScreen());
  }

//MARK: API CALL

  Future<List<PostCodeAddress>> getAddressListFromPostCode(
      String postCode) async {
    addressList = [];
    try {
      await EasyLoading.show(status: 'Loading...');
      await ApiProvider()
          .getAddressListBasedOnPostCode(postCode)
          .then((value) async {
        await EasyLoading.dismiss();
        if (value.code == 2000) {
          addressList = value.addressList ?? [];
        }
      });
    } catch (e) {
      log('$e');
    }
    return addressList;
  }

  finalPostTaskAPI() async {
    // if (double.parse(price) == 0) {
    //   AlertClass.shared.setSnackbar('Please add budget'.tr);
    //   return;
    // }
    // if (!isFixedRate && hourRateController.text.isEmpty) {
    //   AlertClass.shared.setSnackbar('Please add hour and price per hour'.tr);
    //   return;
    // }
    final filterList =
        specificTimeList.where((element) => element.isSelect == true).toList();
    final finalTmpArray = filterList.map((e) => '${e.title} ${e.time}');
    final timeString = finalTmpArray.join(',');
    // for (CertainTime myTime in timeList) {
    //   finalTIme += '${myTime.title} ${myTime.time}';
    // }

    final param = {
      'details': titleController.text,
      'repairing_date': dateController.text,
      // 'hours_estimate': isFixedRate ? '0' : hourController.text,
      'description': descriptionController.text,
      'is_remote_work': isRemotTask ? '1' : '0',
      'location': address,
      // 'time': timeController.text,
      'time': timeString,
      // 'rate_type': isFixedRate ? '1' : '2',
      // 'rate': price,
      // 'rate_per_hour': isFixedRate ? '0' : hourRateController.text,
      'category_id': categoryId,
      'subcategory_id': subCategoryId,
      'latitude': addLat,
      'longitude': addLng,
      'appartment_no': apartNo,
      'floor': floor,
      'city': city,
      'address_label': addressLabel,
      'address_type': addressType,
    };

    try {
      log("Post task Parameters:$param");
      EasyLoading.show(status: 'Loading...'.tr);
      await ApiProvider().addHomeviewerTask(
          param, [imageFile1, imageFile2, imageFile3]).then((value) {
        EasyLoading.dismiss();
        if (value.message == 'success') {
          AlertClass.shared.setSnackbar('Task Created Successfully!!!');
          currentIndexHomeViewer = 0;
          clearAllData();
          NavigationService()
              .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
        } else {
          AlertClass.shared.setSnackbar(value.message);
        }
      });
    } on Exception catch (e) {
      log("Post task ERROR:$e");
    }
  }

  clearAllData() {
    specificTimeList.where((element) => element.isSelect = false).toList();
    locationType.where((element) => element.isSelect = false).toList();
    dateController.clear();
    fixedRateController.clear();
    hourRateController.clear();
    hourController.clear();
    titleController.clear();
    descriptionController.clear();
    timeController.clear();
    // locationController.text = '';
    taskController.text = '';
    isFixedRate = true;
    isRemotTask = false;
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    update();
  }

//USER INTERECTION METHODS

  selectCategory(String id) {
    log('category id:$id');
    categoryId = id;
  }

  selectSubCategoryId(String id) {
    log('sub category id:$id');
    subCategoryId = id;
  }

  addTask() {
    index = index + 1;
    taskList.add(Task(id: index.toString(), title: taskController.text));
    taskController.text = '';
    update();
  }

  removeTask(int index) {
    taskList.removeAt(index);
    update();
  }

  updateTaskType() {
    isRemotTask = !isRemotTask;
    update();
  }

  addLocation({
    required location,
    required String lat,
    required String cityAddress,
    required String lng,
    required String adFloor,
    required String adAptNo,
    required String adAdsLbl,
  }) {
    final selectedAddressType =
        locationType.where((element) => element.isSelect == true).toList();
    address = location;
    addLat = lat;
    addLng = lng;
    apartNo = adAptNo;
    floor = adFloor;
    addressLabel = adAdsLbl;
    addressType = selectedAddressType.first.title ?? '';
    city = cityAddress;
    update();
  }

  calculatePrice() {
    if (isFixedRate) {
      price = fixedRateController.text;
      if (fixedRateController.text.isEmpty) {
        price = '0.0';
      }
    } else {
      if (hourController.text.isEmpty || hourRateController.text.isEmpty) {
        price = '0.0';
        update();
        return;
      }
      price = (double.parse(hourController.text) *
              double.parse(hourRateController.text))
          .toString();
      if (hourRateController.text.isEmpty) {
        price = '0.0';
      }
    }

    update();
  }

  _fillData() {
    specificTimeList = [
      CertainTime(
          icon: Icons.wb_twilight_sharp,
          time: '(8 am to 12 pm)',
          title: 'Morning'.tr,
          isSelect: false),
      CertainTime(
          icon: Icons.wb_sunny_outlined,
          time: '(12 pm to 4 pm )',
          title: 'Afternoon'.tr,
          isSelect: false),
      CertainTime(
          icon: Icons.light_mode_rounded,
          time: '(4 pm to 8 pm)',
          title: 'Evening'.tr,
          isSelect: false),
      CertainTime(
          icon: Icons.wb_sunny_outlined,
          time: '(8 am to 8 pm)',
          title: 'Anytime'.tr,
          isSelect: false),
    ];
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                  onPrimary: Colors.white, // selected text color
                  onSurface: AppColors.colorPrimaryDark
                      .lightColorHex(), // default text color
                  primary:
                      AppColors.colorPrimaryDark.lightColorHex() // circle color
                  ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      dateController.text = "${picked.toLocal()}".split(' ')[0];
    }
    update();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      log('Picked TIme:${pickedTime.hour}');
      log('Picked TIme:${pickedTime.minute.formateNumber()}');
      timeController.text =
          '${pickedTime.hour}:${pickedTime.minute.formateNumber()}';
      update();
    }
  }

  selectFixedTime(int index) {
    // specificTimeList.where((element) => element.isSelect = false).toList();
    specificTimeList[index].isSelect = !specificTimeList[index].isSelect;
    update();
  }

  selectBudgetType(int value) {
    price = '0.0';
    fixedRateController.text = '';
    hourRateController.text = '';
    hourController.text = '';
    if (value == 0) {
      isFixedRate = true;
    } else {
      isFixedRate = false;
    }
    update();
  }
}

class CertainTime {
  String title;
  String time;
  IconData? icon;
  bool isSelect = false;
  CertainTime(
      {this.title = "", this.time = "", this.icon, this.isSelect = false});
}

class Task {
  String title;
  String id;

  Task({this.title = "", this.id = ""});
}

class LOCATION {
  String? title;
  IconData? icon;
  bool? isSelect;
  LOCATION({this.isSelect, this.title, this.icon});
}
