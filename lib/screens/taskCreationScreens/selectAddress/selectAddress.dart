import 'dart:developer';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/model/model_address_list_based_on_postcode.dart';
import 'package:fixz/screens/taskCreationScreens/dateTimeScreen/dateTimeScreen.dart';
import 'package:place_picker/entities/location_result.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  TextEditingController? postCode;
  TextEditingController? selectAddress;
  TextEditingController? flatorHouseNo;
  TextEditingController? addressLine2;
  TextEditingController? town;
  TextEditingController? city;
  TextEditingController? buildingName;
  TextEditingController? floor;
  TextEditingController? addressLabel;
  LocationResult? palce;

  AddTaskController controller = Get.put(AddTaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    postCode = TextEditingController();
    selectAddress = TextEditingController();
    flatorHouseNo = TextEditingController();
    addressLine2 = TextEditingController();
    town = TextEditingController();
    city = TextEditingController();
    buildingName = TextEditingController();
    floor = TextEditingController();
    addressLabel = TextEditingController();
  }

  showAddressDialog(List<PostCodeAddress> value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Address"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = value[index];
                return InkWell(
                  onTap: () {
                    _updateInfo(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: setCommonText('${item.line1}'),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: value.length,
            ),
          ),
        );
      },
    );
  }

  _updateInfo(PostCodeAddress address) {
    selectAddress?.text = address.line1 ?? '';
    town?.text = address.postTown ?? '';
    city?.text = address.district ?? '';
    addressLine2?.text = address.thoroughfare ?? '';
    flatorHouseNo?.text = address.premise ?? '';
    controller.addLocation(
      location:
          '${selectAddress?.text} ${addressLine2?.text} ${town?.text} ${city?.text}',
      lat: '${address.latitude}',
      lng: '${address.longitude}',
      adAdsLbl: '',
      adAptNo: '',
      adFloor: '',
      cityAddress: address.district ?? '',
    );
    setState(() {});
    Navigator.of(context).pop();
  }

  bool isValidate() {
    if (selectAddress!.text.isEmpty ||
        town!.text.isEmpty ||
        city!.text.isEmpty) {
      return false;
    }
    // log('postCode!.text.isEmpty:${postCode!.text.isEmpty}');
    // log('selectAddress!.text.isEmpty:${selectAddress!.text.isEmpty}');
    // log('flatorHouseNo!.text.isEmpty:${flatorHouseNo!.text.isEmpty}');
    // log('town!.text.isEmpty:${town!.text.isEmpty}');
    // log('city!.text.isEmpty:${city!.text.isEmpty}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.lightColorHex(),
      appBar: setAppbar('Add Address'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (SharedManager.shared.isDubaiVersion)
                GetBuilder<AddTaskController>(
                  builder: (con) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                            itemCount: controller.locationType.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (builder, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !controller
                                            .locationType[index].isSelect!
                                        ? Colors.white
                                        : AppColors.colorPrimaryDark
                                            .lightColorHex(),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: controller
                                                .locationType[index].isSelect!
                                            ? Colors.white
                                            : Colors.grey.shade500),
                                  ),
                                  // constraints: BoxConstraints(
                                  //     maxWidth:
                                  //         MediaQuery.sizeOf(context).width / 3),
                                  width: MediaQuery.sizeOf(context).width / 3,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      controller.selectAddressType(index);
                                      // setState(() {});
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          controller.locationType[index].icon,
                                          color: controller
                                                  .locationType[index].isSelect!
                                              ? Colors.white
                                              : Colors.grey.shade500,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${controller.locationType[index].title}',
                                            style: TextStyle(
                                              color: controller
                                                      .locationType[index]
                                                      .isSelect!
                                                  ? Colors.white
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                ),
              if (!SharedManager.shared.isDubaiVersion) setHeight(20),
              if (!SharedManager.shared.isDubaiVersion)
                CommonAddressTextField(
                  hint: 'Post Code',
                  isEditable: true,
                  onEditCompleted: () {
                    if (postCode!.text.isNotEmpty) {
                      controller
                          .getAddressListFromPostCode(postCode!.text.trim())
                          .then((value) async {
                        await EasyLoading.dismiss();
                        log("Address list Data:${value.length}");
                        if (value.isNotEmpty) {
                          showAddressDialog(value);
                        } else {
                          AlertClass.shared.setSnackbar('Postcode not found');
                        }
                      });
                    }
                  },
                  controller: postCode,
                ),
              setHeight(20),
              CommonAddressTextField(
                hint: 'Select an address',
                controller: selectAddress,
                isEditable: SharedManager.shared.isDubaiVersion,
                readOnly: true,
                onTap: () async {
                  //Open Place Picker
                  palce = await SharedManager.shared.showPlacePicker(context);

                  log("get data from place picker:${palce?.city}");
                  selectAddress?.text = palce?.formattedAddress ?? '';
                  city?.text = palce?.city?.name ?? '';
                  town?.text = palce?.city?.name ?? '';
                  addressLine2?.text = palce?.name ?? '';
                },
              ),
              setHeight(20),
              Row(
                children: [
                  Expanded(
                    child: CommonAddressTextField(
                      hint: 'Apt. no.',
                      controller: flatorHouseNo,
                      isEditable: SharedManager.shared.isDubaiVersion,
                    ),
                  ),
                  setWidth(20),
                  if (SharedManager.shared.isDubaiVersion)
                    Expanded(
                      child: CommonAddressTextField(
                        hint: 'Floor',
                        controller: floor,
                        isEditable: SharedManager.shared.isDubaiVersion,
                      ),
                    ),
                ],
              ),
              setHeight(20),
              CommonAddressTextField(
                hint: 'Address line 2',
                controller: addressLine2,
                isEditable: SharedManager.shared.isDubaiVersion,
              ),
              setHeight(20),
              CommonAddressTextField(
                hint: 'Town',
                controller: town,
                isEditable: SharedManager.shared.isDubaiVersion,
              ),
              setHeight(20),
              CommonAddressTextField(
                hint: 'City',
                controller: city,
                isEditable: SharedManager.shared.isDubaiVersion,
              ),
              if (SharedManager.shared.isDubaiVersion)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CommonAddressTextField(
                    hint: 'Address label (optional)',
                    controller: addressLabel,
                    isEditable: SharedManager.shared.isDubaiVersion,
                  ),
                ),
              setHeight(5),
              Text(
                'Give this address a label so you can easily choose between them (e.g. sam\'s home)',
                selectionColor: Colors.grey.shade400,
              ),
              setHeight(100),
              createButton(
                  text: 'NEXT'.tr,
                  fontSize: 15,
                  txtColor: AppColors.white.lightColorHex(),
                  onBtnClick: () {
                    // log('Validation string:${isValidate()}');
                    if (isValidate()) {
                      if (SharedManager.shared.isDubaiVersion) {
                        // if Country is not UK
                        if (controller.locationType
                            .where((element) => element.isSelect == true)
                            .toList()
                            .isEmpty) {
                          AlertClass.shared
                              .setSnackbar('Please select address type'.tr);
                          return;
                        }
                        controller.addLocation(
                          location:
                              '${selectAddress?.text} ${addressLine2?.text} ${town?.text} ${city?.text}',
                          lat: '${palce?.latLng?.latitude}',
                          lng: '${palce?.latLng?.longitude}',
                          adAdsLbl: addressLabel?.text ?? '',
                          adAptNo: flatorHouseNo?.text ?? '',
                          adFloor: floor?.text ?? '',
                          cityAddress: city?.text ?? '',
                        );
                      }
                      NavigationService().setNavigator(const DateTimeScreen());
                    } else {
                      AlertClass.shared.setSnackbar('Please add address first');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonAddressTextField extends StatelessWidget {
  final String hint;
  final bool isEditable;
  final bool readOnly;
  final Function? onEditCompleted;
  final Function? onTap;
  final TextEditingController? controller;
  const CommonAddressTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.onEditCompleted,
      this.onTap,
      this.readOnly = false,
      this.isEditable = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      enabled: isEditable,
      readOnly: readOnly,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(maxHeight: 0),
        contentPadding: const EdgeInsets.only(bottom: 0),
        labelText: hint,
        labelStyle:
            TextStyle(fontSize: 15, color: AppColors.black.lightColorHex()),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black.lightColorHex()),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black.lightColorHex()),
        ),
      ),
      onTap: () {
        onTap?.call();
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onEditCompleted?.call();
      },
    );
  }
}
