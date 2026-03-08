// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/screens/moreScreen/editProfile/controller/editProfileController.dart';
import 'package:place_picker/place_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String? email;
  final String? name;
  final String? image;
  final String? phone;
  final String? location;

  const EditProfileScreen(
      {Key? key,
      required this.email,
      required this.name,
      required this.image,
      required this.phone,
      required this.location})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with AppbarMixin, TextFieldMixin, ButtonMixin {
  //Variables

  final controller = Get.put(EditProfileController());

  //User Interection Method
  _setProfileView() {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (controller.imgFile != null)
                      ? Image(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(
                              controller.imgFile?.path ?? '',
                            ),
                          ),
                          height: 100,
                          width: 100,
                        )
                      : setNetworkImage(widget.image ?? dummyProfile, 100, 100),
                )),
            Positioned(
                bottom: 10,
                right: 0,
                child: InkWell(
                  onTap: () {
                    _openImagePicker();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _openImagePicker() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        controller.imgFile = value;
      });
    });
  }

  _openLocationPicker() async {
    // String placeName;
    // var place = await PluginGooglePlacePicker.showAutocomplete(
    //     mode: PlaceAutocompleteMode.MODE_OVERLAY,
    //     typeFilter: TypeFilter.GEOCODE);
    // placeName = place.name ?? "Null place name!".tr;
    // if (!mounted) return;
    // debugPrint("Place Name:$placeName");
    // controller.addPostalCode(placeName);
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          mapKey,
        ),
      ),
    );
    if (!mounted) return;

    controller.addPostalCode(result.formattedAddress ?? '');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fillData(widget.name ?? '', widget.email ?? '',
        widget.phone ?? '', widget.location ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Edit Profile'.tr,
          backIconColor: Colors.white,
          textColor: AppColors.white.lightColorHex(),
          onBackClick: () {}),
      body: GetBuilder<EditProfileController>(
        builder: (con) {
          return Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              children: [
                setHeight(15),
                _setProfileView(),
                setHeight(25),
                setTextField(
                    height: 45,
                    hint: 'Name'.tr,
                    hintColor: Colors.grey.shade400,
                    fontSize: 15,
                    controller: con.nameController),
                setHeight(25),
                setTextField(
                    height: 45,
                    hint: 'Email'.tr,
                    isEditable: false,
                    hintColor: Colors.grey.shade400,
                    fontSize: 15,
                    controller: con.emailController),
                setHeight(25),
                setTextField(
                    height: 45,
                    hint: 'Mobile'.tr,
                    hintColor: Colors.grey.shade400,
                    fontSize: 15,
                    keyboardType: TextInputType.number,
                    isEditable: con.mobileController.text.isEmpty,
                    controller: con.mobileController),
                setHeight(25),
                InkWell(
                  onTap: () {
                    _openLocationPicker();
                  },
                  child: setTextField(
                    height: 45,
                    hint: 'Location'.tr,
                    hintColor: Colors.grey.shade400,
                    fontSize: 15,
                    controller: con.locationController,
                    isEditable: false,
                  ),
                ),
                setHeight(50),
                createButton(
                    text: 'Update'.tr,
                    txtColor: Colors.white,
                    onBtnClick: () {
                      con.updateProfile();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
